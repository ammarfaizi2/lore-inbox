Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRKSKTE>; Mon, 19 Nov 2001 05:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRKSKSy>; Mon, 19 Nov 2001 05:18:54 -0500
Received: from mail012.syd.optusnet.com.au ([203.2.75.172]:57736 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S277294AbRKSKSu>; Mon, 19 Nov 2001 05:18:50 -0500
Message-ID: <001401c170e4$1d890d20$1e50a8c0@kinslayer>
From: "Joel Beach" <joelbeach@optushome.com.au>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E165lCN-00061N-00@the-village.bc.nu>
Subject: Re: Maximum (efficient) partition sizes for various filesystem types...
Date: Mon, 19 Nov 2001 21:22:38 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I'll fix up that bit in the Debian manual myself then if they let
me....

For what it's worth, here's the paragraph from the "Woody" installation
manual:

"For new users, personal Debian boxes, home systems, and other single-user
setups, a single / partition (plus swap) is probably the easiest, simplest
way to go. It is possible to have problems with this idea, though, with
larger (20GB) disks. Based on limitations in how ext2 works, avoid any
single partition greater than 6GB or so."

Joel

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Joel Beach" <joelbeach@optushome.com.au>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, November 19, 2001 8:58 PM
Subject: Re: Maximum (efficient) partition sizes for various filesystem
types...


> > For instance, the Debian guide says that, due to Ext2 efficiency,
partitions
> > greater than 6-7GB shouldn't be created. Is this true for Ext3/ReiserFS.
>
> I've run several 45-200Gb ext2 and ext3 partitions with no problem. I'm
not
> sure what the origin of the Debian guide comemnt is but I've never heard
> it from an ext2 developer
>
> Obviously pick a journalled fs for big partitions 8)

