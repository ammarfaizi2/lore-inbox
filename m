Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVDTNiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVDTNiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVDTNiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 09:38:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40854 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261623AbVDTNiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 09:38:00 -0400
Subject: Re: GPL violation by CorAccess?
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>, linux-kernel@vger.kernel.org,
       Karel Kulhavy <clock@twibright.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-os@analogic.com,
       Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <1114002429.774.45.camel@localhost.localdomain>
References: <20050419175743.GA8339@beton.cybernet.src>
	 <20050419182529.GT17865@csclub.uwaterloo.ca>
	 <Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
	 <42656319.6090703@nortel.com>
	 <Pine.LNX.4.61.0504191741190.19956@chaos.analogic.com>
	 <42659620.5050002@nortel.com>  <1113982209.3803.7.camel@gimli.at.home>
	 <1114001398.774.40.camel@localhost.localdomain>
	 <1114001836.6238.68.camel@laptopd505.fenrus.org>
	 <1114002429.774.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 15:37:49 +0200
Message-Id: <1114004269.6238.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 09:07 -0400, Steven Rostedt wrote:
> On Wed, 2005-04-20 at 14:57 +0200, Arjan van de Ven wrote:
> > On Wed, 2005-04-20 at 08:49 -0400, Steven Rostedt wrote:
> > > On Wed, 2005-04-20 at 09:30 +0200, Bernd Petrovitsch wrote:
> > > 
> > > > 
> > > > As long as they do not statically link against LGPL (or GPL) code and as
> > > > long as they do not link dynamically agaist GPL code. And there are
> > > > probably more rules .....
> > > > 
> > > 
> > > Actually, I believe that the LGPL allows for static linking as well.
> > 
> > it does, as long as you provide the .o files of your own stuff so that
> > the end user can relink with  say a bugfixed version of library.
> 
> I don't see that in the license.  As point 5 showed: "Such a
> work, in isolation, is not a derivative work of the Library, and

you missed the point "in isolation". If you do NOT link against the lib,
eg your app in isolation, you don't have to care abuot the LGPL. That is
what it says. The moment you do link you are no longer "in isolation".


