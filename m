Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTLJPzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTLJPzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:55:45 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:23744 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S263646AbTLJPzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:55:43 -0500
Date: Wed, 10 Dec 2003 16:55:41 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: PPP over ttyUSB (visor.o, Treo)
Message-ID: <20031210165540.B26394@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello @subscribers,

does anybody have working PPP over ttyUSB device in 2.6 kernels?
When I connect the Handspring Treo to the 2.6.0-test11 machine,
I am able to synchronize it, but not to run PPP to it (it can work
as modem). I am able to dial the modem connection using AT commands,
but I am not able to run PPP over it. Firstly the chat(1) program
complains about not being able to get terminal attributes (TCGETATTR,
from strace output), and then pppd(8) complains about not being able
to set terminal attributes (TCSETATTR from the strace output).
In 2.4 the same setup works OK.

	Any hints? (Kernel config and other details are available
on request). Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
