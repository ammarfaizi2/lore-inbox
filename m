Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSEFQOu>; Mon, 6 May 2002 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314549AbSEFQOu>; Mon, 6 May 2002 12:14:50 -0400
Received: from gate.in-addr.de ([212.8.193.158]:12560 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S314548AbSEFQOt>;
	Mon, 6 May 2002 12:14:49 -0400
Date: Mon, 6 May 2002 18:14:27 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-devel] Re: UML is now self-hosting!
Message-ID: <20020506181427.K918@marowsky-bree.de>
In-Reply-To: <20020505082505.GE2392@matchmail.com> <200205051225.HAA01629@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-05-05T07:25:00,
   Jeff Dike <jdike@karaya.com> said:

> MOSIX (or Compaq's SSI) would certainly be a way of doing it.  It happens
> that there's a particularly simple way of doing it with UML.  You'd partition
> UML's 'physical' memory between the hosts, and use the fact that those pages
> are really virtual to fault them between hosts as needed.  This would perform
> particularly badly, but its simplicity appeals to me.

An interesting and simple approach indeed; but spreading an instance across
multiple nodes is nowhere as simple as it seems; where do you keep OS data, IO
access, scheduling decisions, inter-node communication in the first place, how
to deal with node failure etc...

However, I believe it could potentially be implemented cleaner than currently
with the Compaq SSI stuff, because the encapsulation is better etc; but I have
been known to be wrong ;-)

It would certainly be very interesting. If you _really_ want to open this can
of worms, you should consider joining linux-cluster mailing list for this, or
the Open Clustering Framework list (because you are going to stumble into the
madness which is "interoperability and lack of standards" here).


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

