Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTLOOoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTLOOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:44:44 -0500
Received: from mail6.iserv.net ([204.177.184.156]:12168 "EHLO mail6.iserv.net")
	by vger.kernel.org with ESMTP id S263666AbTLOOon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:44:43 -0500
Message-ID: <3FDDC8BC.1090802@didntduck.org>
Date: Mon, 15 Dec 2003 09:44:12 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
CC: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>	 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>	 <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
In-Reply-To: <3FDDBDFE.5020707@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev wrote:

> Got it.
> Should I understand it this way: for system with >=1Gb RAM, I will be 
> unable to ioremap 256Mb region?
> It looks confusing. On my test system (don't ask details, I am not 
> alowed to share this info), I see
> video controller with 256Mb BAR. Does it mean this controller will not 
> work as well?

But that video card's BAR is not ioremapped into the kernel (XFree86 
will mmap it into userspace).

--
               Brian Gerst

