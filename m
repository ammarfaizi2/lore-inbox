Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBGQjQ>; Wed, 7 Feb 2001 11:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129214AbRBGQjH>; Wed, 7 Feb 2001 11:39:07 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:63498 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S129116AbRBGQi4>; Wed, 7 Feb 2001 11:38:56 -0500
Date: Wed, 7 Feb 2001 08:38:54 -0800
From: David Rees <dbr@spoke.nols.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <20010207083854.F24270@spoke.nols.com>
Mail-Followup-To: David Rees <dbr@spoke.nols.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
In-Reply-To: <3A813A63.EBD1B768@namesys.com> <420500000.981560829@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <420500000.981560829@tiny>; from mason@suse.com on Wed, Feb 07, 2001 at 10:47:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 10:47:09AM -0500, Chris Mason wrote:
> 
> Ok, how about we list the known bugs:
> 
> zeros in log files, apparently only between bytes 2048 and 4096 (not
> reproduced yet).

Could this bug be related to the reported corruption that people with
new VIA chipsets have been also reporting on ext2?  It seems similar
because of the location of the corruption:

http://marc.theaimsgroup.com/?l=linux-kernel&m=98147483712620&w=2

Anyway, it can't hurt to ask the bug reported if they're using a
newer VIA chipset and see if they will upgrade their BIOS which seems
to fix the problem.

-Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
