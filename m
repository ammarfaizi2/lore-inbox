Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUE0SNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUE0SNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUE0SNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:13:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36062 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264919AbUE0SNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:13:04 -0400
Date: Thu, 27 May 2004 19:13:02 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: FabF <fabian.frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
Message-ID: <20040527181301.GR12308@parcelfarce.linux.theplanet.co.uk>
References: <1085679127.2070.21.camel@localhost.localdomain> <20040527180118.GQ12308@parcelfarce.linux.theplanet.co.uk> <1085681215.2070.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085681215.2070.27.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 08:06:55PM +0200, FabF wrote:
> On Thu, 2004-05-27 at 20:01, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> > On Thu, May 27, 2004 at 07:32:08PM +0200, FabF wrote:
> > > Andrew,
> > > 
> > > 	Here's a patch to have standard __put_user for integer transfers in lp
> > > driver.Is it correct ?
> > 
> > What the hell for?  copy_to_user()/copy_from_user() is perfectly OK here.
> > 
> And why the hell use generic functions when we have neat small type
> exchange macros ?

We have different definitions of "neat", apparently.
