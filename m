Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284831AbRLPVUS>; Sun, 16 Dec 2001 16:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284820AbRLPVUJ>; Sun, 16 Dec 2001 16:20:09 -0500
Received: from mons.uio.no ([129.240.130.14]:52223 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284831AbRLPVTw>;
	Sun, 16 Dec 2001 16:19:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15389.4070.855955.296791@charged.uio.no>
Date: Sun, 16 Dec 2001 22:19:34 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112162154080.16845-100000@Appserv.suse.de>
In-Reply-To: <15388.60557.527680.468341@charged.uio.no>
	<Pine.LNX.4.33.0112162154080.16845-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > On Sun, 16 Dec 2001, Trond Myklebust wrote:
    >> I found the bug. It's a pretty ugly race...

     > Well, you found _a_ bug perhaps, but not this one..  Still
     > repeatedly fails in exactly the same part with your second
     > patch applied instead.

In that case, I'll need a tcpdump of the point at which the error
occurs.

I'm unable to produce any problem whatsoever with the new patch
applied. Certainly not an EIO: that can normally only occur if you are
using soft mounts (which I assume is not the case?) or if the server
is screwed up...

Cheers,
  Trond
