Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbUCSWSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUCSWSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:18:32 -0500
Received: from mail0.lsil.com ([147.145.40.20]:22215 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S263123AbUCSWSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:18:25 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC49E@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Matthew Wilcox'" <willy@debian.org>, "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'Paul Wagland'" <paul@wagland.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al
	pha1
Date: Fri, 19 Mar 2004 17:17:35 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> that you don't do things like
> 
> #if defined(__x86_64__) || defined(__ia64__)
> #endif
> 
> when you really mean
> 
> #ifdef CONFIG_COMPAT
> #endif
What does CONFIG_COMPAT do anyway? We could not find much information about
it's usage
