Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130927AbRAYStx>; Thu, 25 Jan 2001 13:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130929AbRAYStn>; Thu, 25 Jan 2001 13:49:43 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:42505 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S130927AbRAYSte>; Thu, 25 Jan 2001 13:49:34 -0500
Date: Thu, 25 Jan 2001 19:48:23 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question: Memory change request
Message-ID: <20010125194823.D5109@pcep-jamie.cern.ch>
In-Reply-To: <3A6E79EA.C2AD3806@mailhost.cs.rose-hulman.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A6E79EA.C2AD3806@mailhost.cs.rose-hulman.edu>; from donaldlf@hermes.cs.rose-hulman.edu on Wed, Jan 24, 2001 at 12:44:58AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leslie Donaldson wrote:
> I need a block of memory that can notify me or even a flag set when
> it has been written to. I was thinking of letting the user code generate
> some sort of page fault... Any random thoughts would be greatly
> appreciated.

Look for the Boehm garbage collector.  It has code for handling and
recovering from dirty page faults.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
