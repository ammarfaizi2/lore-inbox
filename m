Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTKQR7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTKQR7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:59:54 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:63690 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263618AbTKQR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:59:53 -0500
Date: Mon, 17 Nov 2003 12:57:54 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Lars Ehrhardt <1103@ng.h42.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-bk22 does not compile on sparc64: undefined reference
 to `vga_writeb'
In-Reply-To: <3FB8FCA6.7010804@ng.h42.de>
Message-ID: <Pine.GSO.4.33.0311171251130.26356-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Lars Ehrhardt wrote:
>Ricky Beam wrote:
>> (This has come up a thousand times on the sparclinux list.)
>
>Maybe the help text for VGA_CONSOLE should be adjusted accordingly?
>By reading "Virtually everyone wants that." in the help text I did not
>assume that this option does not make sense on Sparcs.

90% of the help text outside arch directories are targeted at x86 users.
That said, there's a whole lot of stuff one can turn on that very much
will not work anywhere but x86.  I've raised this concern several times
and I'm always dismissed. ("x86 is all that matters.")

The proper answer is to remove the option entirely where it doesn't belong.
As such, the "depends on" needs to be updated to exclude sparc32 and sparc64.
(And MDA_CONSOLE probablly needs to go too.)

--Ricky


