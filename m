Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132813AbRDPATx>; Sun, 15 Apr 2001 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRDPATn>; Sun, 15 Apr 2001 20:19:43 -0400
Received: from [203.117.131.2] ([203.117.131.2]:31985 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S132813AbRDPAT3>; Sun, 15 Apr 2001 20:19:29 -0400
From: "Michael Clark" <michael@metaparadigm.com>
To: <david_j_findlay@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: IP Acounting Idea for 2.5
Date: Mon, 16 Apr 2001 08:21:46 +0800
Message-ID: <HBEEKENFCJOPCENEDAGHGEPBCBAA.michael@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <01041707532801.00352@workshop>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the 2.5 series of kernels, working towards 2.6, could you please make the
> IP Accounting so that I can set a single rule that will make it watch all IP
> traffic going from the local network, through the masquerading service to the
> internet, and log local IP Addresses using it? This would allow me to set 1
> rule, but have the information I want on a per IP address system.

You could try using a mature userspace traffic meter like 'NeTraMet' (uses
libpcap).

ftp://ftp.auckland.ac.nz/pub/iawg/NeTraMet/

> One other person I have talked to would like to see this too, and he
> basically says we need a software version of the Cisco IP Accounting
> server/router.

NeTraMet can also account using Cisco Netflow accounting records.

> Could you please add this to the next kernel? Please CC me your responses as
> I am not a member of the kernel mailing list. Thanks,
>
> David
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

