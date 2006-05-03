Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWECKlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWECKlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 06:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWECKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 06:41:07 -0400
Received: from uproxy.gmail.com ([66.249.92.175]:51107 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965146AbWECKlG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 06:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aYHq+e9NHjKySrRFAoVTe3CkCuz4WWVGi2QWLobfOjwOpAefGI63tIq/EewdD1CYPlz8LrTmaE7jOmxNUa6BUgdRrSw4yVhfCgxvGt1Is0n8GUM15ssEkPnTJV6R4Q3ELpL90o4Mu/Iwr0Lr0dpE6ijoUzfuQfKeLvijgxQJyMM=
Message-ID: <625fc13d0605030341h2a105f49r2b1b610547e30022@mail.gmail.com>
Date: Wed, 3 May 2006 05:41:04 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Nicolas Pitre" <nico@cam.org>
Subject: Re: [RFC] Advanced XIP File System
Cc: "Jared Hulbert" <jaredeh@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
	 <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 2 May 2006, Josh Boyer wrote:
>
> > On 5/2/06, Jared Hulbert <jaredeh@gmail.com> wrote
> > >
> > > Why a new filesystem?
> > > - XIP of kernel is mainline, but not XIP of applications.  This
> > > enables application XIP
> >
> > From what I recall, XIP of the kernel off of MTD is limited to ARM.
>
> It doesn't have to.

Yes, I realize that all that is needed is support from other archs.  A
more general form of the question would be does AXFS depend on
ARCH_MTD_XIP?

josh
