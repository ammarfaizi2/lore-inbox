Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbTCOXrT>; Sat, 15 Mar 2003 18:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261692AbTCOXrT>; Sat, 15 Mar 2003 18:47:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10204
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261691AbTCOXrS>; Sat, 15 Mar 2003 18:47:18 -0500
Subject: Re: [patch] NUMAQ subarchification
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: colpatch@us.ibm.com, James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <247240000.1047693951@flay>
References: <1047676332.5409.374.camel@mulgrave>
	 <3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com>
	 <247240000.1047693951@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047776836.1327.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 01:07:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 02:05, Martin J. Bligh wrote:
> No, *please* don't do this. Subarch for .c files is *broken*.
> Last time I looked (and I don't think anyone has fixed it since) 
> it requires copying files all over the place, making an unmaintainable
> nightmare. Either subarch needs fixing first, or we don't use it.

It was fixed in about 2.5.50-ac. I thought Linus had picked up the 
improved version of mach-default* too. Its used extensively for stuff
like PC9800 which is deeply un-PC

