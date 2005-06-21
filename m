Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVFUPga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVFUPga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFUPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:36:29 -0400
Received: from [212.100.255.31] ([212.100.255.31]:5863 "EHLO
	blue.eye.binarydream.org") by vger.kernel.org with ESMTP
	id S262125AbVFUPgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:36:01 -0400
Date: Tue, 21 Jun 2005 16:35:52 +0100
From: Uriel <uriell@binarydream.org>
To: linux-kernel@vger.kernel.org
Subject: Re: v9fs (-mm -> 2.6.13 merge status)
Message-ID: <20050621153552.GJ22656@server4.lensbuddy.com>
References: <20050620235458.5b437274.akpm@osdl.org> <a4e6962a05062106515757849d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a05062106515757849d@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 08:51:27AM -0500, Eric Van Hensbergen wrote:
> On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > v9fs
> > 
> >     I'm not sure that this has a sufficiently high
> >     usefulness-to-maintenance-cost ratio.

The 9P protocol implemented by v9fs is the result of over a decade of 
research in distributed systems at Bell Labs by the original Unix team,
and it has various implementations for other operating systems that have
been used in production systems for many years.

9P is designed to be portable across systems and transport protocols,
it's network transparent, and it gives us interoperativity with
Inferno(which can run hosted under Linux already), Plan 9, and p9p, and
implementations for *BSD and other systems are in the works.

9P has the potential to become the standard protocol for distributed
resources and I don't think any of the alternatives come anywhere near
being as well designed, well proven and encompassing.

uriel
