Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbTCORr1>; Sat, 15 Mar 2003 12:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbTCORr1>; Sat, 15 Mar 2003 12:47:27 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46559 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261476AbTCORr0>; Sat, 15 Mar 2003 12:47:26 -0500
Date: Sat, 15 Mar 2003 09:58:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [patch] NUMAQ subarchification
Message-ID: <16190000.1047751081@[10.10.2.4]>
In-Reply-To: <1047750799.1964.72.camel@mulgrave>
References: <1047676332.5409.374.camel@mulgrave><3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com> <247240000.1047693951@flay> <1047750799.1964.72.camel@mulgrave>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> No, *please* don't do this. Subarch for .c files is *broken*.
> 
> It is the place designed for code belonging only to one subarch.

That doesn't mean it's not broken.
 
>> Let's just stick with your original patch - it's fine.
> 
> No, it's not.  The object of the subarch is to remove all subarch
> specific files from the main i386/kernel directory.

It needs fixing to avoid the duplication first ... after that it'll 
be a fine idea. Until that, I'm not moving any code under there.

M.

