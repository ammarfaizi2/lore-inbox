Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRA0SSh>; Sat, 27 Jan 2001 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130651AbRA0SS2>; Sat, 27 Jan 2001 13:18:28 -0500
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:58118 "EHLO Ion.var.cx")
	by vger.kernel.org with ESMTP id <S130324AbRA0SSL>;
	Sat, 27 Jan 2001 13:18:11 -0500
Date: Sat, 27 Jan 2001 19:18:09 +0100
From: Frank v Waveren <fvw@var.cx>
To: David Wagner <daw@cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127191809.A3727@var.cx>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <14960.56461.296642.488513@pizda.ninka.net> <3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no> <94tho8$627$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <94tho8$627$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Sat, Jan 27, 2001 at 04:10:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 04:10:48AM +0000, David Wagner wrote:
> Practice being really, really paranoid.  Think: You're designing a
> firewall; you've got some reserved bits, currently unused; any future code
> that uses them could behave in completely arbitrary and insecure ways,
> for all you know.  Now recall that anything not known to be safe should
> be denied (in a good firewall) -- see Cheswick and Bellovin for why.
> When you take this point of view, it is completely understandable why
> firewalls designed before ECN was introduced might block it.

Why? Why not just zero them, and get both security and compatibility...

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|dse.nl|stack.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: http://www.var.cx/pubkey/fvw@var.cx-gpg     7179 3036 E136 B85D

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
