Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287907AbSAPVab>; Wed, 16 Jan 2002 16:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287896AbSAPVaZ>; Wed, 16 Jan 2002 16:30:25 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:31982 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S287882AbSAPVaC>; Wed, 16 Jan 2002 16:30:02 -0500
Message-ID: <056c01c19ed4$f0e77300$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Andrea Arcangeli" <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Cc: "Rik van Riel" <riel@conectiva.com.br>
In-Reply-To: <20020116200459.E835@athlon.random>
Subject: Re: Rik spreading bullshit about VM
Date: Wed, 16 Jan 2002 16:29:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Jan 2002 21:29:55.0516 (UTC) FILETIME=[F0E947C0:01C19ED4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
<snip>
>I don't have a single bugreport about the current 2.4.18pre2aa2 VM (except 
>perhaps the bdflush wakeup that seems to be a little too late and that deals to 
>lower numbers with slow write load etc.., fixable with bdflush tuning). 

I don't know if this is a reference to the issue I reported under the "Writeout in
recent kernels..." thread or not. If not, my apologies for clogging up this new
"discussion".

As reported[0] in the above-mentioned thread, the bdflush tuning parameters
you suggested made no difference in my test case other than slightly adjusting
the temporal relationship between writeout and file transfer. -aa still performs
slightly worse than both 2.4.17 stock and -rmap. 2.4.13-ac7 currently beats
all competitors.

--Adam

[0] http://www.kroptech.com:8300/mailimport/showmsg.php?msg_id=49746&db_name=linux_kernel

