Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129423AbQK3PrD>; Thu, 30 Nov 2000 10:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130093AbQK3Pqx>; Thu, 30 Nov 2000 10:46:53 -0500
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:16909 "EHLO
        irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
        id <S129423AbQK3Pqk> convert rfc822-to-8bit; Thu, 30 Nov 2000 10:46:40 -0500
Date: Thu, 30 Nov 2000 16:16:12 +0100 (MEZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: Gunter Königsmann <gunter.koenigsmann@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.17, makefile bug
In-Reply-To: <Pine.LNX.4.21.0011301602080.617-100000@calcula.uni-erlangen.de>
Message-Id: <Pine.A32.3.95.1001130161500.45774A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2000, [ISO-8859-1] Gunter Königsmann wrote:

> 'make bzlilo'
> compiles the kernel, and runs lilo, but it fails to copy it to
> /boot/vmlinuz before that.

You remembered to modify the toplevel Makefile (see comments there)
if you want the new kernel in /boot rather than the default location of /,
did you?

Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
