Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSC2CBP>; Thu, 28 Mar 2002 21:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311915AbSC2CBF>; Thu, 28 Mar 2002 21:01:05 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:51191 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S310806AbSC2CBC>; Thu, 28 Mar 2002 21:01:02 -0500
Message-ID: <00a601c1d6c5$93620320$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Dave Jones" <davej@suse.de>, "Bob Miller" <rem@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200203281216.32590@xsebbi.de> <00c801c1d655$d8e75cd0$02c8a8c0@kroptech.com> <20020328095352.A6291@doc.pdx.osdl.net> <20020328200331.B5064@suse.de>
Subject: Re: [2.5.7-dj2] Compile Error
Date: Thu, 28 Mar 2002 21:01:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Mar 2002 02:01:01.0313 (UTC) FILETIME=[93692F10:01C1D6C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Dave Jones" <davej@suse.de>
To: "Bob Miller" <rem@osdl.org>
Cc: "Adam Kropelin" <akropel1@rochester.rr.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, March 28, 2002 2:03 PM
Subject: Re: [2.5.7-dj2] Compile Error


> On Thu, Mar 28, 2002 at 09:53:52AM -0800, Bob Miller wrote:
>  > So if you build with CONFIG_BSD_PROCESS_ACCT not set you're build will
>  > break.  I'm in the process of generating a patch that will make acct.c
>  > again conditionally compile based on CONFIG_BSD_PROCESS_ACCT.  This
>  > should be done in a little bit and I'll post.
>  > 
>  > Dave, where did you get the patch for acct.c?
> 
> Al Viro's 0-aliases-c-C7-pre2
> It looks like killing the first occurance of acct.o in kernel/Makefile
> should do the trick. Let me know if that works out.

Works For Me (tm).

(but see my other message for an oops report)

--Adam


