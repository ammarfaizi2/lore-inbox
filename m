Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280125AbRJaJnD>; Wed, 31 Oct 2001 04:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbRJaJmy>; Wed, 31 Oct 2001 04:42:54 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:65453 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S280125AbRJaJmr>;
	Wed, 31 Oct 2001 04:42:47 -0500
Date: Wed, 31 Oct 2001 10:43:24 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5 && vtun not working
Message-ID: <20011031104323.A2263@schmorp.de>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.0.20011029174700.08e93090@mail1> <20011029.175312.26299226.davem@redhat.com> <20011031010500.B383@schmorp.de> <20011031.003056.63128206.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20011031.003056.63128206.davem@redhat.com>
X-Operating-System: Linux version 2.4.13-ac5 (root@cerebro) (gcc version 2.95.4 20010319 (prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 12:30:56AM -0800, "David S. Miller" <davem@redhat.com> wrote:
> You're right, it should allow the "string has no '%' at all" case
> as well.  Please, someone send me a patch which does this.

My original mail contained a one-line fix, suboptimal but works fine for me.
I also found a more elaborate patch:

   http://www.geocrawler.com/lists/3/SourceForge/12162/0/6896612/

it seems to use a fancier algorithm and has been used by more people.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
