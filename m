Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRKVThj>; Thu, 22 Nov 2001 14:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281560AbRKVThT>; Thu, 22 Nov 2001 14:37:19 -0500
Received: from cj723460-a.alex1.va.home.com ([24.23.56.237]:2185 "EHLO
	CJ723460-A.alex1.va.home.com") by vger.kernel.org with ESMTP
	id <S281541AbRKVThQ>; Thu, 22 Nov 2001 14:37:16 -0500
Date: Thu, 22 Nov 2001 14:36:39 -0500
From: "G . Sumner Hayes" <sumner-kernel-nospam@forceovermass.com>
To: =?iso-8859-1?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
Cc: James A Sutherland <jas88@cam.ac.uk>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
Message-ID: <20011122143639.A2964@forceovermass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFD4F57.8030408@wanadoo.fr>; from stilgar2k@wanadoo.fr on Thu, Nov 22, 2001 at 08:17:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 08:17:43PM +0100, François Cami wrote:
> James A Sutherland wrote:
> 
> > Hmm... if you've experimented with this, how does this setup compare
> > to a striped RAID of hda+hdc used for root and swap? (i.e. is the
> > speedup down to splitting accesses between two spindles?)
> 
> I haven't, but it's a good idea, I may give it a try, but not very soon.

You shouldn't need striping for this--if you have two swap partitions
with equal priority, the kernel will "stripe" them itself.

At least that's my understanding.

  Sumner
