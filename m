Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423712AbWJaR3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423712AbWJaR3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423714AbWJaR3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:29:40 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:20881 "EHLO mx1.mandriva.com")
	by vger.kernel.org with ESMTP id S1423712AbWJaR3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:29:39 -0500
Date: Tue, 31 Oct 2006 14:28:57 -0300
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Thiago Galesi <thiagogalesi@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-ID: <20061031172856.GE5319@mandriva.com>
References: <20061030213318.GA5319@mandriva.com> <20061030203334.09caa368.akpm@osdl.org> <82ecf08e0610310805x6a77c2d3pd46eb2f76f75af67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <82ecf08e0610310805x6a77c2d3pd46eb2f76f75af67@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 02:05:06PM -0200, Thiago Galesi wrote:
> >>       Further ideas on how to use the DWARF2 information include tools
> >> that will show where inlines are being used, how much code is added by
> >> inline functions,
> >
> >It would be quite useful to be able to identify inlined functions which are
> >good candidates for uninlining.
> >
> >-
> 
> Arnaldo, can't we get a call count for functions? (yes, it is not a
> run-time call count, but rather, how many times the function if called
> in the code) I guess this would help for this purpose of finding
> candidates for inlining, uninlining.

At least for inline expansions, yes, for normal function calls I have to
study more the DWARF2 documentation, but I guess its feasible.

- Arnaldo
