Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSE3AQF>; Wed, 29 May 2002 20:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSE3AQE>; Wed, 29 May 2002 20:16:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40189 "EHLO branoic")
	by vger.kernel.org with ESMTP id <S315785AbSE3AQE>;
	Wed, 29 May 2002 20:16:04 -0400
Date: Wed, 29 May 2002 20:15:55 -0400
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: William Lee Irwin III <wli@holomorphy.com>,
        "David S. Miller" <davem@redhat.com>, frank.schafer@setuza.cz,
        linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
Message-ID: <20020530001555.GA4831@branoic.them.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, frank.schafer@setuza.cz,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10205192307500.26915-100000@rain.cise.ufl.edu> <20020519.214053.19164382.davem@redhat.com> <1021876190.250.7.camel@ADMIN> <20020520.141800.52934272.davem@redhat.com> <20020529235116.GB3797@branoic.them.org> <20020530000311.GY14918@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 05:03:11PM -0700, William Lee Irwin III wrote:
> On Mon, May 20, 2002 at 02:18:00PM -0700, David S. Miller wrote:
> >> I can't see any reason why lack of PTRACE_READDATA prevents follow
> >> fork mode support in GDB.
> 
> On Wed, May 29, 2002 at 07:51:16PM -0400, Daniel Jacobowitz wrote:
> > It doesn't.  Follow-fork support is possible now, with a speed hit, but
> > I am waiting for better kernel support; it should be forthcoming with
> > the task ornament-based debugging interface proposed some time ago.
> 
> What is this and who is working on it?

David Howells, at the same time as the rest of the task ornaments
stuff.  You'd have to ask him what the current state of it is.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
