Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTJAW5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTJAW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:57:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4626 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262669AbTJAW5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:57:47 -0400
Date: Wed, 1 Oct 2003 18:57:46 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Rik van Riel <riel@redhat.com>
cc: Chris Wright <chrisw@osdl.org>, <torvalds@osdl.org>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <vserver@solucorp.qc.ca>
Subject: Re: sys_vserver
In-Reply-To: <Pine.LNX.4.44.0310011744030.19538-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310011852270.15287-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Rik van Riel wrote:

> On Wed, 1 Oct 2003, Chris Wright wrote:
> 
> > I believe a reasonable portion of vserver can become a security module,
> > but there would clearly remain a need for some of the virtualization
> > (e.g. hostname, etc.).
> 
> I definately want to have as much as possible of vserver
> using the normal security infrastructure, simply because
> it will save the vserver maintainers a lot of work ;)
> 

I think virtualization is important/useful enough to warrant an API of
it's own.  It could be similar to LSM, e.g.  allow pluggable
virtualization modules, with no cost for the base kernel.



- James
-- 
James Morris
<jmorris@redhat.com>


