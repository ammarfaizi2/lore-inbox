Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKNJ0P>; Tue, 14 Nov 2000 04:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKNJ0F>; Tue, 14 Nov 2000 04:26:05 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:3420
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129047AbQKNJZ6>; Tue, 14 Nov 2000 04:25:58 -0500
Date: Tue, 14 Nov 2000 10:53:18 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.2.17 [klogd bonus question]
Message-ID: <20001114105317.D3096@jaquet.dk>
In-Reply-To: <20001113162155.A18009@jaquet.dk> <20001113231008.G18203@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001113231008.G18203@wire.cadcamlab.org>; from peter@cadcamlab.org on Mon, Nov 13, 2000 at 11:10:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 11:10:08PM -0600, Peter Samuelson wrote:
> 
> [Rasmus Andersen]
> > I'm getting oopses on a linux 2.2.17 box when I try to do
> > tar cvIf <file> -X<file> /. Reproducably.
> 
> Are you excluding /proc?  Trying to back up all of /proc is definitely
> asking for trouble, although the oops still indicates a kernel bug.

Good suggestion. But I exclude /proc and anyways it crashes before I get
to that part of the fs.

Regards,
  Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
