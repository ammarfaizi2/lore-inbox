Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268586AbTGJAMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbTGJAJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:09:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29833 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268906AbTGJAIs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:08:48 -0400
Message-ID: <3F0CB1F3.6050104@pobox.com>
Date: Wed, 09 Jul 2003 20:23:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
References: <20030709133109.A23587@infradead.org>	 <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>	 <16140.24595.438954.609504@charged.uio.no>	 <200307092041.42608.m.c.p@wolk-project.de>	 <16140.25619.963866.474510@charged.uio.no> <20030709190531.GF15293@gtf.org>	 <16140.26693.72927.451259@charged.uio.no>  <20030709191739.GH15293@gtf.org> <1057794132.7137.13.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057794132.7137.13.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-07-09 at 20:17, Jeff Garzik wrote:
> 
>>Having the stable API change, conditional on a define, is really
>>nasty and IMO will create maintenance and support headaches down
>>the line.  I do not recall Linux VFS _ever_ having a hook's definition
>>conditional.  We should not start now...
> 
> 
> The new quota code in 2.4.22pre already changed the rules slightly, as
> do the shmemfs fixes if you are pedantic

I am ;-)

