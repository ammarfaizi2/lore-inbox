Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTDOVfE (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTDOVfE 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:35:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46017
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264104AbTDOVe7 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:34:59 -0400
Subject: Re: DMA transfers in 2.5.67
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xy92be915.fsf@zaphod.guide>
References: <yw1x3ckjfs2v.fsf@zaphod.guide>
	 <1050438684.28586.8.camel@dhcp22.swansea.linux.org.uk>
	 <yw1xy92be915.fsf@zaphod.guide>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1050439715.28586.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 21:48:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 22:38, Måns Rullgård wrote:
> It's an Alpha with 768 MB.  Is it the pci_alloc_* functions you are
> referring to?  I don't think they are used currently. How much memory
> can these allocate?  I need chunks of up to 1 MB, not necessarily
> phycically continuous.
> 
> What do those functions do that normal memory allocation does not?
> Apart from setting up sg mappings, that is.

A normal memory allocation might not be visible from the device, however
pci_map_sg() deals with such things. What I really meant was are you
using the pci_ DMA functionality

