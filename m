Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSGIN1i>; Tue, 9 Jul 2002 09:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGIN1h>; Tue, 9 Jul 2002 09:27:37 -0400
Received: from basket.ball.reliam.net ([213.91.6.7]:62725 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S315279AbSGIN1c>; Tue, 9 Jul 2002 09:27:32 -0400
Date: Tue, 9 Jul 2002 15:31:23 +0200
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <159820870.20020709153123@uni.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re[3]: [PATCH] 2.4 IDE core for 2.5
In-Reply-To: <20020709125412.GB1940@suse.de>
References: <20020709102249.GA20870@suse.de> <01742490.20020709144349@uni.de>
 <20020709125412.GB1940@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

Tuesday, July 9, 2002, 2:54:12 PM, you wrote:

JA> Try doing something ala

JA> #ifdef CONFIG_IDE_25
JA> #include <linux/ide.h>  /* IDE xlate */
JA> #else
JA> #include <linux/ide24.h>
JA> #endif

JA> instead of including ide.h directly in fs/partitions/msdos.c

Just a minute ago I booted and wanted to take your hint, but before
this I tried `make bzImage' again (no idea why, just for fun) and
it compiled! This results from the fact that I booted the new
kernel with the new IDE core including.

Yes, it works now. Thanks anyway, I'm sure you'll interpret this
happening rightly.

-- 
cheers,
  Tobias

http://freebits.org

