Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTIQCoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbTIQCoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:44:04 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:45323 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262667AbTIQCoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:44:02 -0400
Date: Tue, 16 Sep 2003 23:46:21 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions
Message-ID: <20030917024620.GD11420@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>, torvalds@osdl.org
References: <20030916235729.GA6198@kroah.com> <20030917023630.24595.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917023630.24595.qmail@lwn.net>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 16, 2003 at 08:36:30PM -0600, Jonathan Corbet escreveu:
> > How about just exporting them in the files where they are declared?  I
> > do not think we want the ksyms.c file to grow anymore.
> 
> Hmm, I figured somebody would say something like that...grumble...mutter...
> ...complain...gripe...moan...new patch appended...
> 
> Of course, there are other exports from that file (i.e. register_chrdev());
> are we actively trying to shrink ksyms.c?

Linus call, perhaps, but I for one would love to see it just die, having it
in the files that actually implement the functions exported is IMHO more
maintainer friendly, not that ksyms.c is that much touched but...

- Arnaldo
