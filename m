Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNXRN>; Thu, 14 Dec 2000 18:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNXRD>; Thu, 14 Dec 2000 18:17:03 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:60678 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129260AbQLNXQ6>; Thu, 14 Dec 2000 18:16:58 -0500
Date: Thu, 14 Dec 2000 17:46:24 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Clayton Weaver <cgweav@eskimo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <20001214174624.K760@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <Pine.SUN.3.96.1001214042948.15033A-100000@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SUN.3.96.1001214042948.15033A-100000@eskimo.com>; from cgweav@eskimo.com on Thu, Dec 14, 2000 at 04:42:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 04:42:03AM -0800, Clayton Weaver wrote:
> There has a been a thread on the teTeX mailing list the last few days
> about a (RedHat, but probably more general than just their rpms)
> gcc-2.9.6 w/glibc-2.2.x bug. At -O2, it can miscompile 
> 
> unsigned varname; /* "unsigned int varname;" is ok */
> 
> (no problem at -O or no optimization at all, and doesn't happen if teTeX
> is compiled with kgcc).

That one is fixed already for some time, it was a bug in loop unrolling
(that patch is still pending review for the mainline CVS though).

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
