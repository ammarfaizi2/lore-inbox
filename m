Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284019AbRLTWPR>; Thu, 20 Dec 2001 17:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286413AbRLTWPI>; Thu, 20 Dec 2001 17:15:08 -0500
Received: from [206.168.69.42] ([206.168.69.42]:5504 "HELO
	xerxes.data-raptors.com") by vger.kernel.org with SMTP
	id <S284034AbRLTWO7>; Thu, 20 Dec 2001 17:14:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Elyse Grasso <emgrasso@data-raptors.com>
Reply-To: emgrasso@data-raptors.com
To: Dave Jones <davej@suse.de>
Subject: Re: apm gpf on Inspiron2500 with 2.4.9
Date: Thu, 20 Dec 2001 15:13:04 -0700
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112200117210.26043-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112200117210.26043-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011220221506Z284034-18284+5230@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll look into that. 

The gpfs happen whenever Linux tries to do anything apm related, including 
bringing up apmd at boot time, bringing up pcmcia (which evidently calls 
apmd)... whenever.

On Wednesday 19 December 2001 05:19 pm, Dave Jones wrote:
> On Wed, 19 Dec 2001, Elyse Grasso wrote:
> 
> > EIP:  0050:[<00002ffb>]       Not tainted
> 
> The 0050 means you went bang in BIOS context.
> See if theres a BIOS upgrade available.
> 
> If this is occuring at shutdown time, try the "Use real mode APM
> BIOS call to power off" option in the APM section of the kernel
> configuration.
> 
> Dave,
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> 
> 
> 
