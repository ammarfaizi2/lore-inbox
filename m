Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbSACQg7>; Thu, 3 Jan 2002 11:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287406AbSACQgu>; Thu, 3 Jan 2002 11:36:50 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:41998 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287396AbSACQgf>;
	Thu, 3 Jan 2002 11:36:35 -0500
Date: Thu, 3 Jan 2002 14:36:31 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020103143630.D25846@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MAp4-00018b-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16MAp4-00018b-00@starship.berlin>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 03, 2002 at 05:34:27PM +0100, Daniel Phillips escreveu:
> On January 3, 2002 05:05 pm, Ion Badulescu wrote:
> > Daniel Phillips wrote:
> > > -static inline struct inode * new_inode(struct super_block *sb)
> > > +static inline struct inode *new_inode (struct super_block *sb)
> > 
> > Minor issue of coding style. I'd steer away from such gratuitious changes, 
> > especially since they divert from the commonly accepted practice of having 
> > no spaces between the name of the function and its arguments.
> 
> That's good advice and I'm likely to adhere to it - if you can show that 
> having no spaces between the name of the function and its arguments really is 
> the accepted practice.  I've seen both styles on my various travels though 
> the kernel, and I prefer the one with the space.  Much as I prefer to put 
> spaces around '+' (but not around '.', go figure).

Maybe CodingStyle should have an entry for this, I'd vote for this style:

static inline struct inode *new_inode(struct super_block *sb)

> In general, I allow myself the indulgence of cleaning up the odd line here 
> and there to be more pleasing to my eyes, so long as it's in the vicinity of 
> a substantive change and doesn't introduce a new patch hunk.  You could think 
> of it as a perk that takes some of the sting out of doing the grunt work.

fair, thats what I usually do as well 8)

- Arnaldo
