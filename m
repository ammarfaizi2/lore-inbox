Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTDNWn0 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTDNWn0 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:43:26 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:24471 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263965AbTDNWnZ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:43:25 -0400
Subject: Re: [CFT] Hopefully fix PCMCIA boot deadlocks
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, seanlkml@rogers.com,
       Dominik Brodowski <linux@brodo.de>
In-Reply-To: <20030414165057.C22754@flint.arm.linux.org.uk>
References: <20030414165057.C22754@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1050360903.677.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 15 Apr 2003 00:55:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 17:50, Russell King wrote:
> Ok,
> 
> Here's my latest patch against 2.5.67 which introduces a proper state
> machine into the PCMCIA layer for handling the sockets.  Unfortunately,
> I fear that this isn't the answer for the following reasons:

Well, maybe it's not the answer, but it's working for me with
2.5.67-mm3. Besides being too verbose, I have tried booting with the
card plugged, booting with the card unplugged and then plugging it, and
plugging/unplugging it several time to check that hotplug is working.

Haven't found any problems, although I'm testing right now on my main
system (my everyday use laptop).

Nice work, Russell :-)

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

