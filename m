Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbTEEVcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTEEVcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:32:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:43532 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261388AbTEEVcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:32:45 -0400
Date: Mon, 5 May 2003 18:45:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: John Cherry <cherry@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
Message-ID: <20030505214537.GB19272@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	John Cherry <cherry@osdl.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com> <1052168752.27203.175.camel@cherrypit.pdx.osdl.net> <20030505213909.GA2431@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505213909.GA2431@mars.ravnborg.org>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 05, 2003 at 11:39:10PM +0200, Sam Ravnborg escreveu:
> On Mon, May 05, 2003 at 02:05:52PM -0700, John Cherry wrote:
> > 
> > modules (allmodconfig)    1975 warnings        1567 warnings
> >                             60 errors            57 errors
> 
> Is it possible to see a diff of .68 and .69 to see where the
> improvements came from?
> I did not find it on the web-page. If not possible take this as a 
> feature request.

Removing MOD_{INC,USE}_COUNT with proper module accounting, using
SET_MODULE_OWNER in net_devices, I removed all of the related to struct sock
and struct socket accounting, etc.

- Arnaldo
