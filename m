Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268044AbTB1SRM>; Fri, 28 Feb 2003 13:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268045AbTB1SRL>; Fri, 28 Feb 2003 13:17:11 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:7151 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S268044AbTB1SRK>; Fri, 28 Feb 2003 13:17:10 -0500
Date: Fri, 28 Feb 2003 11:27:19 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: Deepak Saxena <dsaxena@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
       linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228182719.GA15093@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su> <20030228155841.GA4678@gtf.org> <20030228181729.GA8366@xanadu.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228181729.GA8366@xanadu.az.mvista.com>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to add/clarify that I'm not suggesting this only for the
mapping functions, but for the whole DMA API. So for example, 
dma_alloc_coherent would again return a dma_handle that is valid on
the bus that dev->bus points to.

~Deepak


-- 
Deepak Saxena, Code Monkey - Ph:480.517.0372 Fax:480.517.0262 
MontaVista Software - Powering the Embedded Revolution - www.mvista.com

