Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSLGRjg>; Sat, 7 Dec 2002 12:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSLGRjg>; Sat, 7 Dec 2002 12:39:36 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:63761 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264620AbSLGRjf>; Sat, 7 Dec 2002 12:39:35 -0500
Date: Sat, 7 Dec 2002 15:46:58 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: erik@hensema.xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: /proc/pci deprecation?
Message-ID: <20021207174658.GD10322@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	erik@hensema.xs4all.nl, linux-kernel@vger.kernel.org
References: <997222131F7@vcnet.vc.cvut.cz> <slrnav3qp5.1c2.usenet@bender.home.hensema.net> <20021207131559.GA737@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207131559.GA737@gallifrey>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 07, 2002 at 01:15:59PM +0000, Dr. David Alan Gilbert escreveu:
> * Erik Hensema (usenet@hensema.xs4all.nl) wrote:
> > 
> > Every half-decent installer autodetects all PCI devices. AND had lspci
> > installed in the install image.
> 
> Yes, but wait till you find yourself stuck on a weird embedded board
> with a small flash and a serial console and you are trying to debug the
> PCI device you've built.

In this weird embedded board with small flash it'd be lovely to save one
more page (or perhaps more) in the kernel image, no? :-)
 
> Sure in most cases you have lspci (and its friends); but why do people
> want to deprecate a perfectly good tool that occasionally comes in
> useful? (Make it a compile time option sure, remove it - no).

See above. And as you said lspci mostly is available. Remove it or make
it a compile time option, please.

- Arnaldo
