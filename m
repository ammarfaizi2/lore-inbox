Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUHRSJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUHRSJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUHRSJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:09:16 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:1547 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S267396AbUHRSJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:09:15 -0400
Date: Wed, 18 Aug 2004 20:09:05 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Oops modprobing i830 with 2.6.8.1
Message-ID: <20040818180902.GA19060@hardeman.nu>
References: <20040817220816.GA14343@hardeman.nu> <20040817233732.GA8264@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040817233732.GA8264@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 12:37:32AM +0100, Dave Jones wrote:
>On Wed, Aug 18, 2004 at 12:08:18AM +0200, David Härdeman wrote:
> > [drm:i830_probe] *ERROR* Cannot initialize the agpgart module.
>
>You don't have agpgart (and an agp chipset subdriver) loaded, yet
>drm 'needs' it.
> 

Indeed, modprobing intel-agp before i830 solved it. Certainly not along 
the principles of least surprise. Thanks for the help!

Regards,
David
