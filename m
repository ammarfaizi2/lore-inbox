Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUCKCqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 21:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbUCKCq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 21:46:27 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:26105 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262969AbUCKCqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 21:46:21 -0500
Message-ID: <404FD24D.1070200@pacbell.net>
Date: Wed, 10 Mar 2004 18:43:25 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Grant Grundler <iod00d@hp.com>, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net>	<16457.12968.365287.561596@napali.hpl.hp.com>	<404959A5.6040809@pacbell.net>	<16457.26208.980359.82768@napali.hpl.hp.com>	<4049FE57.2060809@pacbell.net>	<20040308061802.GA25960@cup.hp.com>	<16460.49761.482020.911821@napali.hpl.hp.com>	<404CEA36.2000903@pacbell.net>	<16461.35657.188807.501072@napali.hpl.hp.com>	<404E00B5.5060603@pacbell.net>	<16462.1463.686711.622754@napali.hpl.hp.com>	<404E2B98.6080901@pacbell.net>	<16462.48341.393442.583311@napali.hpl.hp.com>	<404F40C2.3080003@pacbell.net> <16463.22710.230252.777998@napali.hpl.hp.com>
In-Reply-To: <16463.22710.230252.777998@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

>   >> The current OHCI relies on the internals of the dma_pool()
>   >> implementation.  ...
>   David.B> It'd be good if you said _how_ you think it relies on such
>   David.B> internals.
> 
> I thought I did.  Suppose somebody changed the dma_pool code such that
> it would overwrite freed memory with an 0xf00000000000000 pattern. 

Erm, _anything_ the dma_pool code does with freed memory is legal.
Even the old "monkeys flying out of the back of the server" trick!  :)


Anyway, please (a) see if 2.6.4 works for you, and (b) direct any
future followups on this thread _only_ to linux-usb-devel.

- Dave


