Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUJUADA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUJUADA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269175AbUJUACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:02:48 -0400
Received: from baikonur.stro.at ([213.239.196.228]:22941 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S270560AbUJUAA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:00:58 -0400
Date: Thu, 21 Oct 2004 02:01:00 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Hanna Linder <hannal@us.ibm.com>
Cc: kernel-janitors@lists.osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, perex@suse.cz, sailer@ife.ee.ethz.ch
Subject: Re: [KJ]  [PATCH 2.6.9-rc2-mm4 cmipci.c] [8/8]	Replace pci_find_device with pci_dev_present
Message-ID: <20041021000100.GE1953@stro.at>
References: <28440000.1096502897@w-hlinder.beaverton.ibm.com> <20041020230128.GB1953@stro.at> <32220000.1098313960@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32220000.1098313960@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello hanna,

On Wed, 20 Oct 2004, Hanna Linder wrote:

> --On Thursday, October 21, 2004 01:01:28 AM +0200 maximilian attems <janitor@sternwelten.at> wrote:
> 
> >> +		if (!pci_dev_present(intel_82437vx)) 
> >                                                     ^
> >>  			snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_TXVX);
> >>  		break;
> >>  	default:
> >> 
> >> 
> > 
> > a second one with small whitespace damage.
> > fixed for next kjt.
> 
> Hi Max,
> 
> According to the CodingStyle I should not put a white space
> after the function name and before the parenthesis. 
> 
> I do not believe that should be added.
> 
> Thanks.
> 
> Hanna

agreed.

sorry for being unclear,
i meant newly introduced trailing whitespace in both cases.

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

