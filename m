Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129857AbQKNLJI>; Tue, 14 Nov 2000 06:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbQKNLI6>; Tue, 14 Nov 2000 06:08:58 -0500
Received: from ns.caldera.de ([212.34.180.1]:21772 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129798AbQKNLIv>;
	Tue, 14 Nov 2000 06:08:51 -0500
Date: Tue, 14 Nov 2000 11:38:40 +0100
From: Olaf Kirch <okir@caldera.de>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Olaf Kirch <okir@caldera.de>, Michal Zalewski <lcamtuf@dione.ids.pl>,
        BUGTRAQ@securityfocus.com, linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse.
Message-ID: <20001114113839.M30730@monad.caldera.de>
In-Reply-To: <Pine.LNX.4.21.0011132040160.1699-100000@ferret.lmh.ox.ac.uk> <Pine.LNX.4.21.0011132352550.31869-100000@dione.ids.pl> <20001114095921.E30730@monad.caldera.de> <20001114112926.A1498@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001114112926.A1498@win.tue.nl>; from dwguest@win.tue.nl on Tue, Nov 14, 2000 at 11:29:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 11:29:26AM +0100, Guest section DW wrote:
> Where is the overflow? If charset has 35 characters then
> 	sprintf(buf, "nls_%s", charset);
> writes 40 bytes into buf, and that fits.

Duh. You're right. Stupid me.

Sorry for the confusion.

Olaf
-- 
Olaf Kirch         |  --- o --- Nous sommes du soleil we love when we play
okir@monad.swb.de  |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
okir@caldera.de    +-------------------- Why Not?! -----------------------
         UNIX, n.: Spanish manufacturer of fire extinguishers.            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
