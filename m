Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTKQQwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTKQQwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:52:06 -0500
Received: from ns.km0938.keymachine.de ([62.141.48.247]:33508 "EHLO
	km0938.keymachine.de") by vger.kernel.org with ESMTP
	id S263578AbTKQQwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:52:04 -0500
Message-ID: <3FB8FCA6.7010804@ng.h42.de>
Date: Mon, 17 Nov 2003 17:51:50 +0100
From: Lars Ehrhardt <1103@ng.h42.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk22 does not compile on sparc64: undefined reference
 to `vga_writeb'
References: <Pine.GSO.4.33.0311171131070.26356-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0311171131070.26356-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:

> On Mon, 17 Nov 2003, Lars Ehrhardt wrote:
>>2.6.0-test9 does not compile on sparc64:
>>
>>(...)
>>
> "CONFIG_VGA_CONSOLE=y" is your problem.  Sparcs don't have a VGA console.
> Use the prom console or a FB (or serial console.)

Thanks. That worked.

> (This has come up a thousand times on the sparclinux list.)

Maybe the help text for VGA_CONSOLE should be adjusted accordingly?
By reading "Virtually everyone wants that." in the help text I did not
assume that this option does not make sense on Sparcs.

Kind regards

Lars Ehrhardt

