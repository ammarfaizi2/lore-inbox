Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSFMIne>; Thu, 13 Jun 2002 04:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317511AbSFMInd>; Thu, 13 Jun 2002 04:43:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:22790 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317498AbSFMInc>; Thu, 13 Jun 2002 04:43:32 -0400
Message-ID: <3D085B2A.D1514C7A@aitel.hist.no>
Date: Thu, 13 Jun 2002 10:43:22 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@mole.bio.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: <Pine.SGI.4.33.0206130241230.4638397-100000@mole.bio.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> That means in words that we allocate buffers only once and for all
> existing cpu SOCKETS, i.e. including all potentially hotpluggable cpus
> which are currently offline. - If someone invents hotpluggable cpu sockets
> at some point then they should be burnt at the stake! (-;

How about doing NUMA by hot-plugging PCI cards, each containing
a cpu and some memory?  You never know how many of those
they'll plug in.  

PCI cards with a x86 isn't new either, although I haven't heard of
them being used in this manner before.

Helge Hafting
