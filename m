Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281738AbRKVUiE>; Thu, 22 Nov 2001 15:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281740AbRKVUhm>; Thu, 22 Nov 2001 15:37:42 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:26872 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281738AbRKVUhh>; Thu, 22 Nov 2001 15:37:37 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: James A Sutherland <jas88@cam.ac.uk>
To: "G . Sumner Hayes" <sumner-kernel-nospam@forceovermass.com>,
        =?iso-8859-15?q?Fran=E7ois=20Cami?= <stilgar2k@wanadoo.fr>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 20:37:20 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20011122143639.A2964@forceovermass.com>
In-Reply-To: <20011122143639.A2964@forceovermass.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E1670b2-0003Nj-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 7:36 pm, G . Sumner Hayes wrote:
> On Thu, Nov 22, 2001 at 08:17:43PM +0100, François Cami wrote:
> > James A Sutherland wrote:
> > > Hmm... if you've experimented with this, how does this setup compare
> > > to a striped RAID of hda+hdc used for root and swap? (i.e. is the
> > > speedup down to splitting accesses between two spindles?)
> >
> > I haven't, but it's a good idea, I may give it a try, but not very soon.
>
> You shouldn't need striping for this--if you have two swap partitions
> with equal priority, the kernel will "stripe" them itself.
>
> At least that's my understanding.

It'll stripe the SWAP area, but not the root FS; what I'm interested in is 
how performance is affected by splitting both across two devices, compared to 
putting one on each.


James.
