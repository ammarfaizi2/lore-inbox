Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131619AbQLLOUi>; Tue, 12 Dec 2000 09:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbQLLOU3>; Tue, 12 Dec 2000 09:20:29 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:21564
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131619AbQLLOUQ>; Tue, 12 Dec 2000 09:20:16 -0500
Date: Tue, 12 Dec 2000 14:49:43 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Pavel Machek <pavel@suse.cz>, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove warning from drivers/net/hp100.c (240-test12-pre7)
Message-ID: <20001212144943.L3742@jaquet.dk>
In-Reply-To: <20001208211908.D599@jaquet.dk> <20001209101924.A126@bug.ucw.cz> <20001209163740.U6567@cadcamlab.org> <20001211213208.B600@jaquet.dk> <14901.27835.458672.526580@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14901.27835.458672.526580@wire.cadcamlab.org>; from peter@cadcamlab.org on Mon, Dec 11, 2000 at 06:09:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2000 at 06:09:31PM -0600, Peter Samuelson wrote:
> 
> [Rasmus Andersen]
> > How about this patch? It moves the offending struct to the __init
> > function where it is used and inside an existing #ifdef CONFIG_PCI.
> 
> Hmmmm, if you're messing around with the pci device table, why not just
> convert it to use new-style PCI init?  This is fairly easy to do (I did
> one driver myself, and that *proves* it's easy).  The main points:

I was looking into that regarding another driver anyway, so I'll try
my hand at that. Expect some b0rken patches soon :)

Regards,
  Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
