Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbQLSSsX>; Tue, 19 Dec 2000 13:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129950AbQLSSsO>; Tue, 19 Dec 2000 13:48:14 -0500
Received: from hera.cwi.nl ([192.16.191.1]:434 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129904AbQLSSsG>;
	Tue, 19 Dec 2000 13:48:06 -0500
Date: Tue, 19 Dec 2000 19:17:06 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: [PATCH] ident of whole-disk ext2 fs
Message-ID: <20001219191706.B367@veritas.com>
In-Reply-To: <3A3F42FC.4E341732@yahoo.com> <20001219184542.A367@veritas.com> <00121919461703.02742@rosomak.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <00121919461703.02742@rosomak.prv>; from dalecki@evision-ventures.com on Tue, Dec 19, 2000 at 07:46:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 07:46:17PM +0100, Martin Dalecki wrote:
> Dnia Wto 19. Grudzie? 2000 18:45, Andries Brouwer napisa?:
> > But what if you just replace the "unknown partition table"
> > by "no recognized partition table"
> 
> What about the more correct. 
> hdd: no partition table
> 
> There is no presumed "unknown" partition table at all
> when we can't recognize it.

That is more confusing. The user tends to believe such messages
and will start reformatting / fdisking etc, while in reality
the problem may be that she forgot to enable CONFIG_OSF_PARTITION
or so. (And there are also partition types, like AIX partition,
that the kernel currently has no support for.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
