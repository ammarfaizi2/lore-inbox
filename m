Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTIIVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264644AbTIIVkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:40:55 -0400
Received: from lidskialf.net ([62.3.233.115]:7386 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S264591AbTIIVi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:38:28 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: jbarnes@sgi.com (Jesse Barnes)
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Date: Tue, 9 Sep 2003 22:38:26 +0100
User-Agent: KMail/1.5.3
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309092143.58189.adq@lidskialf.net> <20030909211756.GA7487@sgi.com>
In-Reply-To: <20030909211756.GA7487@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309092238.27112.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 September 2003 22:17, Jesse Barnes wrote:
> On Tue, Sep 09, 2003 at 09:43:58PM +0100, Andrew de Quincey wrote:
> > On Tuesday 09 September 2003 21:13, Jesse Barnes wrote:
> > > Instead of going into an infinite loop because the list isn't setup
> > > yet, just return NULL if there are no prt entries.
> >
> > Ah, this is a patch against the vanilla kernel.. This is unfortunately
> > incompatible with my recent ACPI patches.
>
> Maybe you could include it in your patch then?  I noticed that your
> patch changes some of the IRQ routing code...

I'm not sure it is still needed or not. The patch makes a lot of changes as to 
how the acpi_prt list is generated. What triggers the problem exactly, so I 
can test? 

