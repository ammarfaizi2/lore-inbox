Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261902AbRESRPn>; Sat, 19 May 2001 13:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbRESRPc>; Sat, 19 May 2001 13:15:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261894AbRESRPV>;
	Sat, 19 May 2001 13:15:21 -0400
Date: Sat, 19 May 2001 18:14:41 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andries.Brouwer@cwi.nl, bcrl@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH] device arguments from lookup)
Message-ID: <20010519181441.D23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <UTC200105191641.SAA53411.aeb@vlet.cwi.nl> <Pine.GSO.4.21.0105191244520.5339-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0105191244520.5339-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, May 19, 2001 at 12:51:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 12:51:07PM -0400, Alexander Viro wrote:
> clone(), walk(), clunk(), stat() and open() ;-) Basically, we can add
> unopened descriptors. I.e. no IO until you open it (turning the thing into
> opened one), but we can do lookups (move to child), we can clone and
> kill them and we can stat them.

Those who would like a more detailed explanation can find one at
http://plan9.bell-labs.com/sys/man/5/INDEX.html

-- 
Revolutions do not require corporate support.
