Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUIOU0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUIOU0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUIOUZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:25:13 -0400
Received: from [66.35.79.110] ([66.35.79.110]:38596 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267358AbUIOUWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:22:44 -0400
Date: Wed, 15 Sep 2004 13:22:34 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@novell.com>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915202234.GA18242@hockin.org>
References: <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost> <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com> <1095279043.23385.102.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095279043.23385.102.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:10:43PM -0400, Robert Love wrote:
> On Wed, 2004-09-15 at 12:40 -0700, Greg KH wrote:
> 
> > And here's the patch I applied to my trees and will show up in the next
> > -mm release.
> > 
> > I'll go convert Kay's mount patch to the new interface and add it too.
> 
> I think you want an "unmount" signal, too.

So do we actually plan to handle namespaces at all wrt kevents?
