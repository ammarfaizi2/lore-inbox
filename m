Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbUAHK0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUAHK0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:26:41 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:27596 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264127AbUAHK0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:26:40 -0500
Date: Thu, 8 Jan 2004 11:25:48 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-ID: <20040108112547.G20265@fi.muni.cz>
References: <20040107023042.710ebff3.akpm@osdl.org> <20040107215240.GA768@frodo> <20040108105427.E20265@fi.muni.cz> <20040108021637.15d1b33a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040108021637.15d1b33a.akpm@osdl.org>; from akpm@osdl.org on Thu, Jan 08, 2004 at 02:16:37AM -0800
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
: Jan Kasprzak <kas@informatics.muni.cz> wrote:
: >  - this is reliable: repeated boot back to 2.6.1-rc2 makes the problem
: >  	appear again (high load, system slow has hell), booting back
: >  	to -test7 makes it disappear.
: 
: Is the CPU load higher than normal?  Excluding I/O wait?

	No, ~30% system is pretty standard for this server. I have looked
just now (2.6.0-test7), and I have 33% system, about 50% nice,
and the rest is user, iowait and idle. Under 2.6.1-rc2 it was about 30%
system and the rest iowait, with small amount of nice and user.
However, the load may be different. It is hard to have any kind of
"fixed" load when you serve data over FTP, HTTP, rsync and do some
other minor tasks (updatedb, current/up2date server, ...).

	Do you still want the system profiling info?

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
