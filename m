Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289288AbSAIJWB>; Wed, 9 Jan 2002 04:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289295AbSAIJVx>; Wed, 9 Jan 2002 04:21:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59784 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289288AbSAIJVo>;
	Wed, 9 Jan 2002 04:21:44 -0500
Date: Wed, 09 Jan 2002 01:20:46 -0800 (PST)
Message-Id: <20020109.012046.21928803.davem@redhat.com>
To: ncm-nospam@cantrip.org
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        deischen@iworks.InterWorks.org
Subject: Re: bad patch in aic7xxx_linux.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020109090628.A18526@cantrip.org>
In-Reply-To: <20020109090628.A18526@cantrip.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nathan Myers <ncm-nospam@cantrip.org>
   Date: Wed, 9 Jan 2002 09:06:28 +0000

   In patch-2.4.17-pre2, a nonsensical change was made in 
   linux/drivers/scsi/aic7xxx/aic7xxx_linux.c .  While apparently 
   harmless, it suggests to me that you had intended to fold in an 
   entirely different patch, and "missed".
   
Missed?  That patch fixes a lethal bug.

   I don't find a current maintainer for aic7xxx listed in MAINTAINERS.

It's listed in the aic7xxx sources, but the fix in question came to
Marcelo via Jens Axboe.

Franks a lot,
David S. Miller
davem@redhat.com
