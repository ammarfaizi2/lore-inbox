Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTJIMGD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJIMGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:06:03 -0400
Received: from intra.cyclades.com ([64.186.161.6]:48359 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262104AbTJIMGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:06:00 -0400
Date: Thu, 9 Oct 2003 08:41:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: two sym53c8xx.o modules
In-Reply-To: <3F84AF3C.9050408@wanadoo.es>
Message-ID: <Pine.LNX.4.44.0310090826290.2569-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Oct 2003, Xose Vazquez Perez wrote:

> hi,
> 
> kernel 2.4 has two modules with *same name*:
> /lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.o
> /lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx.o
> 
> "# modprobe sym53c8xx" tries to load sym53c8xx.o first and then sym53c8xx_2/sym53c8xx.o
> bug or feature?
> 
> should be sym53c8xx_2/sym53c8xx.o renamed to sym53c8xx_2/sym53c8xx_2.o ?

Xose,

One should not have both drivers loaded at the same time, so I think this
is alright.


