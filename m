Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314038AbSDQNP6>; Wed, 17 Apr 2002 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSDQNP5>; Wed, 17 Apr 2002 09:15:57 -0400
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:1554 "HELO
	gandalf.physik.uni-konstanz.de") by vger.kernel.org with SMTP
	id <S314038AbSDQNP4>; Wed, 17 Apr 2002 09:15:56 -0400
Date: Wed, 17 Apr 2002 15:15:55 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Rob Radez <rob@osinvestor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Watchdog Updates
Message-ID: <20020417151555.B31398@gandalf.physik.uni-konstanz.de>
In-Reply-To: <Pine.LNX.4.33.0204161320110.17511-100000@pita.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 01:49:24PM -0400, Rob Radez wrote:
> Hah, like I'm going to attach two >100k patches to a mail going to l-k.
> It's that time of day again, and instead of just one patch, I have two.
> Not only that, but I only just now noticed the indydog driver, so that's
> got some updates in here too.  Plus, the patches this time include the
> meaning of life, the universe, and everything.  I've changed the format
> of the patch slightly this time, in hopes of getting it applied sometime
> soon.  So, I've put up two patches.
[..snip..] 
+indydog.c -- Hardware Watchdog Device for SGI IP22
+
+	Timeout value unknown.
+	Support KEEPALIVEPING.
+	GETSTATUS and GETBOOTSTATUS return 0.

IP22 machines have a hardwired 1 minute timeout.
 -- Guido
