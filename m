Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbTCPCNj>; Sat, 15 Mar 2003 21:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTCPCNj>; Sat, 15 Mar 2003 21:13:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48516 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262006AbTCPCNj>; Sat, 15 Mar 2003 21:13:39 -0500
Date: Sat, 15 Mar 2003 18:24:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: colpatch@us.ibm.com, James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NUMAQ subarchification
Message-ID: <1650000.1047781459@[10.10.2.4]>
In-Reply-To: <1047776836.1327.11.camel@irongate.swansea.linux.org.uk>
References: <1047676332.5409.374.camel@mulgrave> <3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com> <247240000.1047693951@flay> <1047776836.1327.11.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> No, *please* don't do this. Subarch for .c files is *broken*.
>> Last time I looked (and I don't think anyone has fixed it since) 
>> it requires copying files all over the place, making an unmaintainable
>> nightmare. Either subarch needs fixing first, or we don't use it.
> 
> It was fixed in about 2.5.50-ac. I thought Linus had picked up the 
> improved version of mach-default* too. Its used extensively for stuff
> like PC9800 which is deeply un-PC

Cool, if that's in mainline, we're set ... if not, I guess we need to
pull it out and steal it ;-)

M.

