Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBSIF4>; Mon, 19 Feb 2001 03:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129189AbRBSIFq>; Mon, 19 Feb 2001 03:05:46 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:48650 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129104AbRBSIFh>; Mon, 19 Feb 2001 03:05:37 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A90D140.35468D08@yahoo.com>
Date: Mon, 19 Feb 2001 02:54:40 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Marc Esipovich <marc@corky.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] APMD on Linux 2.2.18 and include/linux/mc146818rtc.h
In-Reply-To: <20010217210245.A16130@marcellos.corky.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Esipovich wrote:
> 
>         I've noticed this when attempting to build APMD, mc146818rtc.h has
> a reference to a spinlock_t while asm/spinlock.h is not included.
> 
>         Patch follows:

User space does not need to ever see any kernel spinlocks - you will find
such a fix for this is in 2.2.19pre already though, so you can make use 
of that.

Thanks for the report anyway,
Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

