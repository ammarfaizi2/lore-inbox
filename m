Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSCFXUz>; Wed, 6 Mar 2002 18:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSCFXUq>; Wed, 6 Mar 2002 18:20:46 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20687 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284933AbSCFXUb>; Wed, 6 Mar 2002 18:20:31 -0500
Date: Wed, 6 Mar 2002 18:20:27 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jeff Dike <jdike@karaya.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020306182026.F866@redhat.com>
In-Reply-To: <3C84F449.8090404@zytor.com> <E16idH7-0002zc-00@starship.berlin> <20020306113632.A22933@redhat.com> <E16ikc5-00032P-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16ikc5-00032P-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Mar 07, 2002 at 12:14:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 12:14:15AM +0100, Daniel Phillips wrote:
> On March 6, 2002 05:36 pm, Benjamin LaHaise wrote:
> > On Wed, Mar 06, 2002 at 04:24:17PM +0100, Daniel Phillips wrote:
> > > On March 6, 2002 04:24 pm, Benjamin LaHaise wrote:
> > > > On Wed, Mar 06, 2002 at 03:59:22PM +0100, Daniel Phillips wrote:
> > > > > Suppose you have 512 MB memory and an equal amount of swap.  You start 8
> > > > > umls with 64 MB each.  With your and Peter's suggestion, the system always
> > > > > goes into swap.  Whereas if the memory is only allocated on demand it
> > > > > probably doesn't.
> > > > 
> > > > As I said previously, going into swap is preferable over randomly killing 
> > > > new tasks under heavy load.
> > > 
> > > Huh?  In the example I gave, you will never oom but with your suggestion, you
> > > will always go needlessly go into swap.  I'm suprised that you and Peter are
> > > aguing in favor of wasting resources.
> > 
> > I'm arguing in favour of predictable behaviour.  Stability and reliability 
> > are more important than a bit of swap space.
> 
> That's the same argument that says memory overcommit should not be allowed.

Go back in the thread: I suggested making it an option that the user has to 
turn on to allow his foot to be shot.  Remember: the common case in the kernel 
is to be using all memory.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
