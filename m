Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRAFVty>; Sat, 6 Jan 2001 16:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135221AbRAFVti>; Sat, 6 Jan 2001 16:49:38 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:45329 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S132575AbRAFVt1>;
	Sat, 6 Jan 2001 16:49:27 -0500
Date: Sat, 6 Jan 2001 22:49:03 +0100
From: Marc Lehmann <pcg@goof.com>
To: Chris Mason <mason@suse.com>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010106224902.A2121@cerebro.laendle>
Mail-Followup-To: Chris Mason <mason@suse.com>,
	Stefan Traby <stefan@hello-penguin.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Daniel Phillips <phillips@innominate.de>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010106210951.A3143@stefan.sime.com> <69400000.978813302@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69400000.978813302@tiny>; from mason@suse.com on Sat, Jan 06, 2001 at 03:35:02PM -0500
X-Operating-System: Linux version 2.2.18 (root@cerebro) (gcc version pgcc-2.95.2.1 20001224 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 03:35:02PM -0500, Chris Mason <mason@suse.com> wrote:
> > Nobody with working brain would read it completely into memory.

Instead everybody with a working brain would introduce another hashing
layer for every block access? I don't think the reiserfs code (e.g.) would
cope with yte another compliation in the code ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
