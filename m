Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTDNIh1 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 04:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTDNIh1 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 04:37:27 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63628 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262865AbTDNIh0 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 04:37:26 -0400
Date: Mon, 14 Apr 2003 08:49:04 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: arjanv@redhat.com, Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-ID: <20030414084904.A15608@devserv.devel.redhat.com>
References: <20030412180852.77b6c5e8.akpm@digeo.com> <20030413151232.D672@nightmaster.csn.tu-chemnitz.de> <1050245689.1422.11.camel@laptop.fenrus.com> <200304140629.h3E6TPu01387@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304140629.h3E6TPu01387@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Apr 14, 2003 at 09:24:26AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 09:24:26AM +0300, Denis Vlasenko wrote:
> >
> > that in itself is easy to find btw; just give every GFP_* an extra
> > __GFP_REQUIRED bit and then check inside kmalloc for that bit (MSB?)
> > to be set.....
> 
> This will incur runtime penalty

but only for CONFIG_DEBUG_KMALLOC or whatever
