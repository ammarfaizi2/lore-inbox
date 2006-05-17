Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWEQS20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWEQS20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWEQS20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:28:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750866AbWEQS2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:28:25 -0400
Date: Wed, 17 May 2006 14:28:08 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       James.Smart@emulex.com, James.Bottomley@steeleye.com,
       ltt-dev@shafik.org
Subject: Re: [RFC] [Patch 0/8] statistics infrastructure
Message-ID: <20060517182808.GL17707@redhat.com>
References: <446A0F77.70202@de.ibm.com> <y0msln8wooo.fsf@ton.toronto.redhat.com> <200605172005.44588.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605172005.44588.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Wed, May 17, 2006 at 08:05:43PM +0200, Andi Kleen wrote:
> [...]
> > It is interesting how many solutions pop up for this sort of problem.
> > The many tracing tools/patches, systemtap, and now this, all share
> > some goals and should ideally share some of the technology.
>
> I disagree. They often have very different requirements - and a
> one-size-fits-all solution will be likely too heavyweight for most
> users.

I am not suggesting a single solution for all needs.  I wanted to
focus only one aspect: the marking of those points in the kernel where
something probeworthy occurs with hooks.  The different tools would
still gather and disseminate their data in their own favorite.  The
main difference from the status quo is agreeing on and reusing a
common pool of hooks.

- FChE
