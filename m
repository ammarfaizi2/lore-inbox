Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283788AbRK3VN0>; Fri, 30 Nov 2001 16:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283785AbRK3VNQ>; Fri, 30 Nov 2001 16:13:16 -0500
Received: from [168.159.129.100] ([168.159.129.100]:40719 "EHLO
	mxic1.isus.emc.com") by vger.kernel.org with ESMTP
	id <S283783AbRK3VNF>; Fri, 30 Nov 2001 16:13:05 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D00241AB42@corpusmx1.us.dg.com>
From: berthiaume_wayne@emc.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: RE: Multicast Broadcast
Date: Fri, 30 Nov 2001 16:12:58 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Andi, it appears that JVM doesn't support the ip_mreqn struct that
would allow us to use imr_ifindex but supports only the older ip_mreq struct
as the optval. Any other suggestions.
Most appreciated,
Wayne
EMC Corp
ObjectStor Engineering
4400 Computer Drive
M/S F213
Westboro,  MA    01580

email:       Berthiaume_Wayne@emc.com
                 WBerthiaume@clariion.com

"One man can make a difference, and every man should try."  - JFK
 

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Thursday, November 29, 2001 4:32 PM
To: berthiaume_wayne@emc.com
Cc: ak@suse.de; linux-kernel@vger.kernel.org
Subject: Re: Multicast Broadcast


On Thu, Nov 29, 2001 at 04:29:22PM -0500, berthiaume_wayne@emc.com wrote:
> 	Andi, forgive my ignorance. I've searched around and can't seem to
> find any references to IP_ADD_MEMBERSHIP and how to use it. I did perform
an

man 7 ip

It is a socket option you use in the program that does the multicast
communication.

-Andi
