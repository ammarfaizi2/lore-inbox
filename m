Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVCNSqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVCNSqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVCNSpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:45:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29931 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261704AbVCNSmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:42:05 -0500
Date: Mon, 14 Mar 2005 12:41:43 -0600
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: Nishanth Aravamudan <nacc@us.ibm.com>, domen@coderock.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 01/14] char/snsc: reorder set_current_state() and
 add_wait_queue()
In-Reply-To: <200503141003.59618.jbarnes@engr.sgi.com>
Message-ID: <Pine.SGI.4.58.0503141235340.106301@gallifrey.americas.sgi.com>
References: <20050306223616.C82751EC90@trashy.coderock.org>
 <200503140945.44323.jbarnes@engr.sgi.com> <20050314175427.GA2993@us.ibm.com>
 <200503141003.59618.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Mar 2005, Jesse Barnes wrote:

> On Monday, March 14, 2005 9:54 am, Nishanth Aravamudan wrote:
> > On Mon, Mar 14, 2005 at 09:45:44AM -0800, Jesse Barnes wrote:
> > > On Sunday, March 6, 2005 2:36 pm, domen@coderock.org wrote:
> > > > Any comments would be, as always, appreciated.
> > >
> > > I don't have a problem with this change, but the maintainer probably
> > > should have been Cc'd.  Greg, does this change look ok to you?  Note that
> > > it's already been committed to the upstream tree, so if it's a bad change
> > > we'll need to have the cset excluded or something.
> >
> > Thanks for the feedback. I don't see a maintainer entry for Greg
> > anywhere in the snsc.{c,h} files or MAINTAINERS. Could someone throw a
> > patch upstream so that whomever should be contacted for this driver will
> > be in the future?
>
> Good point :)  I assumed there was a MODULE_AUTHOR entry.  Here's a patch to
> get Greg more spam^W^W^W^Wadd the relevant info.  Look ok to you Greg?

Looks good.  Apologies to Nish for dropping my
apparently-orphaned code on his doorstep. :-)

Thanks - Greg
