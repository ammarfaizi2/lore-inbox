Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275765AbRJNQa5>; Sun, 14 Oct 2001 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275758AbRJNQaq>; Sun, 14 Oct 2001 12:30:46 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:53450
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S275759AbRJNQac>; Sun, 14 Oct 2001 12:30:32 -0400
Date: Sun, 14 Oct 2001 12:30:41 -0400
From: Chris Mason <mason@suse.com>
To: Ed Tomlinson <tomlins@CAM.ORG>, Alexander Viro <viro@math.psu.edu>,
        Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <2161290000.1003077041@tiny>
In-Reply-To: <20011014155520.EB2DC290B5@oscar.casa.dyndns.org>
In-Reply-To: <Pine.GSO.4.21.0110140133580.3903-100000@weyl.math.psu.edu>
 <2101790000.1003067296@tiny>
 <20011014155520.EB2DC290B5@oscar.casa.dyndns.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, October 14, 2001 11:55:20 AM -0400 Ed Tomlinson
<tomlins@CAM.ORG> wrote:
> 
> Chris, what I suspect is happening is that the mount with the error leaves
> the sem locked.  After this any mount commant hangs - not just ones for
> the USB card read (ie. loop mount to build an initrd fails too..)

Yup, I see the, I'll send a new patch a little later today.

-chris


