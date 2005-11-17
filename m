Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbVKQHOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbVKQHOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 02:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbVKQHOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 02:14:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26525 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161158AbVKQHOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 02:14:39 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Arjan van de Ven <arjan@infradead.org>
To: ncunningham@cyclades.com
Cc: Greg KH <greg@kroah.com>, "Gross, Mark" <mark.gross@intel.com>,
       Pavel Machek <pavel@ucw.cz>, Dave Jones <DaveJ@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <1132176329.25230.125.camel@localhost>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116221047.GA12830@kroah.com>  <1132176329.25230.125.camel@localhost>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 08:14:22 +0100
Message-Id: <1132211663.2840.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 08:25 +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2005-11-17 at 09:10, Greg KH wrote:
> > On Thu, Nov 17, 2005 at 07:20:45AM +1100, Nigel Cunningham wrote:
> > > 
> > > I've also split the one patch that most people see into what is
> > > currently about 225 smaller patches, each adding only one small part, am
> > > writing descriptions for them all and am preparing to build a git tree
> > > from it.
> > 
> > That's great, I didn't know you were doing this.
> > 
> > I'd recommend using quilt instead of git for something like this,
> > because the odds that you will need to change something in patch number
> > 132 out of 225 is pretty good :)
> 
> Yeah. :) I actually wrote my own 'makepatch' script long before I ever
> heard of quilt, and am still using that. It lets me do the same sort of
> thing. Unfortunately I tend to accumulate further changes at the end of
> the series and then have to shift them back into the right place. It
> would be nice to be able to automate that :)

patch-utils have a 'movepatch' option... which flips 2 patches in order,
even when they overlap.


