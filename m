Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271971AbRIQRjI>; Mon, 17 Sep 2001 13:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271958AbRIQRi6>; Mon, 17 Sep 2001 13:38:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271936AbRIQRit>; Mon, 17 Sep 2001 13:38:49 -0400
Date: Mon, 17 Sep 2001 10:37:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: <linux-kernel@vger.kernel.org>, <ast@domdv.de>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010917192022.313ddd5f.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0109171034040.9038-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Stephan von Krawczynski wrote:
>
> > However, at the same time I'd really like to hear about improved
> > behaviour, not just "feels the same". And certainly not "(maybe even
> > worse.."
>
> Hm, sorry for that. But that's what I see. Maybe the problem is now on a
> different field.

Heh. I wasn't blaming you. The code obviously leaves something to be
desired, still.

> BTW: I tried Andrea's brand new patch and have to admit it has a _big_
> performance gain, though I understand you dislike the design very much.

I only dislike one aspect of it, not the whole patch. Andrea has spent a
lot of time doing tuning, which is hugely important for real-world
workloads.  I also suspect from previous patches that he increases
read-ahead aggressively etc.

I'll take a look,

		Linus

