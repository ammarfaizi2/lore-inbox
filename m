Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131081AbRCGOPx>; Wed, 7 Mar 2001 09:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131083AbRCGOPr>; Wed, 7 Mar 2001 09:15:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18187 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131081AbRCGOO1>;
	Wed, 7 Mar 2001 09:14:27 -0500
Date: Wed, 7 Mar 2001 15:13:12 +0100
From: Jens Axboe <axboe@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>,
        Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307151312.F526@suse.de>
In-Reply-To: <E14aGHY-0000Yc-00@the-village.bc.nu> <Pine.LNX.4.10.10103061042250.1989-100000@penguin.transmeta.com> <20010307134824.A3715@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010307134824.A3715@redhat.com>; from sct@redhat.com on Wed, Mar 07, 2001 at 01:48:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Stephen C. Tweedie wrote:
> SCSI certainly lets us do both of these operations independently.  IDE
> has the sync/flush command afaik, but I'm not sure whether the IDE
> tagged command stuff has the equivalent of SCSI's ordered tag bits.
> Andre?

IDE has no concept of ordered tags...

-- 
Jens Axboe

