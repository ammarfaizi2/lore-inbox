Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSACRC3>; Thu, 3 Jan 2002 12:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288270AbSACRCK>; Thu, 3 Jan 2002 12:02:10 -0500
Received: from dsl-213-023-043-223.arcor-ip.net ([213.23.43.223]:20494 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288268AbSACRCG>;
	Thu, 3 Jan 2002 12:02:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Thu, 3 Jan 2002 18:05:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MAp4-00018b-00@starship.berlin> <20020103143630.D25846@conectiva.com.br>
In-Reply-To: <20020103143630.D25846@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MBIw-00018y-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 05:36 pm, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 03, 2002 at 05:34:27PM +0100, Daniel Phillips escreveu:
> > On January 3, 2002 05:05 pm, Ion Badulescu wrote:
> > > Daniel Phillips wrote:
> > > > -static inline struct inode * new_inode(struct super_block *sb)
> > > > +static inline struct inode *new_inode (struct super_block *sb)
> > > 
> > > Minor issue of coding style. I'd steer away from such gratuitious changes, 
> > > especially since they divert from the commonly accepted practice of having 
> > > no spaces between the name of the function and its arguments.
> > 
> > That's good advice and I'm likely to adhere to it - if you can show that 
> > having no spaces between the name of the function and its arguments really is 
> > the accepted practice.  I've seen both styles on my various travels though 
> > the kernel, and I prefer the one with the space.  Much as I prefer to put 
> > spaces around '+' (but not around '.', go figure).
> 
> Maybe CodingStyle should have an entry for this, I'd vote for this style:
>
> static inline struct inode *new_inode(struct super_block *sb)

OK, I'll revise it to that style.  Shall we start an official janitor's style
guide? ;-)

--
Daniel
