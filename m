Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTFHA3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTFHA3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:29:30 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:22287 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264178AbTFHA33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:29:29 -0400
Date: Sat, 7 Jun 2003 21:44:18 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
       kernel-janitor-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][SPARSE] Make all the anonymous structures truly anonymous
Message-ID: <20030608004418.GC11552@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030608004335.GG20872@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608004335.GG20872@michonline.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 07, 2003 at 08:43:35PM -0400, Ryan Anderson escreveu:
> This patch removes the type-names on the anonymous structures.  This
> fixes compilation when using gcc-3.3 (Debian).  Credit for identifying
> the fix goes to Arnaldo Carvalho de Melo <acme@conectiva.com.br>.

Oh, in fact this credits should go to Eduardo Habkost (aka foca), a coworker
that found this behaviour.

- Arnaldo
