Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRJQI6W>; Wed, 17 Oct 2001 04:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJQI6N>; Wed, 17 Oct 2001 04:58:13 -0400
Received: from fw2.aub.dk ([195.24.1.195]:60401 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S274951AbRJQI5z>;
	Wed, 17 Oct 2001 04:57:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre3aa1
Date: Wed, 17 Oct 2001 10:55:50 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <20011016110708.D2380@athlon.random> <E15tUgv-0000Oh-00@Princess> <20011016203821.54c6a959.skraw@ithnet.com>
In-Reply-To: <20011016203821.54c6a959.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15tmUU-0000Aw-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 October 2001 20:38, Stephan von Krawczynski wrote:
>
> Hm, from looking at the presented numbers I tend to believe that you are
> driving this system up to the limits. Very possible that ac kernels deal a
> bit better with the situation because of neat swap-management. But very
> much of your mem is really used by appilcations and very few (in
> comparison) is used by page cache, so there is not really much room to play
> with. If I were to give advice, I'd either
> a) buy mem (something like additional 256 MB)
> or
> b) throw away K, and replace by more resource-conscious stuff like wm,
> or/and an acceptable mail-client like sylpheed.
> Both would do quantum-leaps in your configuration, compared to very small
> playground left for vm treatment. Whatever is swapped could be the wrong
> thing, depending on your further actions.
> Try it and compare the time and memory consumption for:
> a) Startup
> b) Exit
> c) Starting your mail-client
> d) updatedb
> with K and with wm (just to mention a nice example)

e) Just hope the bug is already fixed
On a suggestion from Luigi Genoni I tried 2.4.13-pre3aa1. The problem IS 
infact fixed. From a subjective point of view I would again claim the Andrea 
VM leaves the system much more responsive when updatedb is running than the 
VM in 2.4.12-ac3.

Nice!! :)

Regards.
`Allan
