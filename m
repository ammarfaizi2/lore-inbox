Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbVKPWiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbVKPWiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVKPWiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:38:23 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:31194 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030540AbVKPWiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:38:22 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Greg KH <greg@kroah.com>
Cc: "Gross, Mark" <mark.gross@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <DaveJ@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051116221047.GA12830@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116221047.GA12830@kroah.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1132176329.25230.125.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 17 Nov 2005 08:25:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-11-17 at 09:10, Greg KH wrote:
> On Thu, Nov 17, 2005 at 07:20:45AM +1100, Nigel Cunningham wrote:
> > 
> > I've also split the one patch that most people see into what is
> > currently about 225 smaller patches, each adding only one small part, am
> > writing descriptions for them all and am preparing to build a git tree
> > from it.
> 
> That's great, I didn't know you were doing this.
> 
> I'd recommend using quilt instead of git for something like this,
> because the odds that you will need to change something in patch number
> 132 out of 225 is pretty good :)

Yeah. :) I actually wrote my own 'makepatch' script long before I ever
heard of quilt, and am still using that. It lets me do the same sort of
thing. Unfortunately I tend to accumulate further changes at the end of
the series and then have to shift them back into the right place. It
would be nice to be able to automate that :)

Nigel

