Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLGSgh>; Thu, 7 Dec 2000 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131131AbQLGSg1>; Thu, 7 Dec 2000 13:36:27 -0500
Received: from Cantor.suse.de ([194.112.123.193]:2821 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131099AbQLGSgN>;
	Thu, 7 Dec 2000 13:36:13 -0500
Date: Thu, 7 Dec 2000 19:05:35 +0100
From: Andi Kleen <ak@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andi Kleen <ak@suse.de>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
Message-ID: <20001207190535.A31574@gruyere.muc.suse.de>
In-Reply-To: <20001207171353.A28798@gruyere.muc.suse.de> <Pine.GSO.3.96.1001207173802.21086G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1001207173802.21086G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Dec 07, 2000 at 05:55:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 05:55:07PM +0100, Maciej W. Rozycki wrote:
>  The NMI should be left alone, though, I think as we want it to be fast
> for the NMI watchdog.  Task gates are not necessarily fast (depending on
> how you define "fast").

How often does the NMI watchdog handler run ? 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
