Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVJJOib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJJOib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJJOib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:38:31 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3287 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750815AbVJJOia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:38:30 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Vivek Kutal <vivek.kutal@gmail.com>
Subject: Re: Need for SHIFT and MASK
Date: Mon, 10 Oct 2005 17:37:38 +0300
User-Agent: KMail/1.8.2
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
References: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com> <200510091423.24660.ioe-lkml@rameria.de> <b9a245c10510091140q78c2480dqb095a7cdab12932e@mail.gmail.com>
In-Reply-To: <b9a245c10510091140q78c2480dqb095a7cdab12932e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510101737.39171.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 October 2005 21:40, Vivek Kutal wrote:
> Hi Ingo,
> 
> > This is usally table driven and someone has to set up
> > this "Page Translation Tables". That's a job of the Linux kernel.
> 
> Yes setting up the page table entries is the job of the kernel , but
> for that we need to put the physical add. of the page and some bits
> (present,access writes etc) in the entry, once it is done the main job
> of translation which requires the masking and shifting is done by the
> processor whenever that page is referenced .
> so why these macros are present in the kernel?

They are needed. You can remome them.

NB: joke tags are invisible, but they are there.
--
vda
