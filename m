Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVH3PtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVH3PtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVH3PtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:49:07 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:20056 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751445AbVH3PtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:49:06 -0400
Message-ID: <43147FF1.60707@tls.msk.ru>
Date: Tue, 30 Aug 2005 19:49:05 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
References: <20050830093715.GA9781@midnight.suse.cz>
In-Reply-To: <20050830093715.GA9781@midnight.suse.cz>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Hi!
> 
> The D-Link DWL-G730AP devices from the Kernel Summit run Linux, And it's
> likely a GPL violation, too, since sources are nowhere to be found.
> 
> They're based on a Marvell Libertas AP-32 (ARM9) design, similar
> to the ASUS WL-530g. A bootlog from the ASUS (which has telnet enabled
> for some reason, and thus can be logged in) is at the end of the mail.
> 
> A firmware image is available from D-Link ([URL removed]) and it seems
> to be composed of compressed blocks padded by zeroes. I haven't verified
> yet that it's indeed a compressed kernel, cramfs, etc, but it seems
> quite likely.

Why [URL removed] ? ;)

There's an ongoing project to "bring some power" into other D-Link
devices (from DSL series; one of them, DSL-G604T (which I own) has
an access point too) at http://mcmcc.bat.ru/dlinkt/ .  This stuff is
also based on the same design, it seems (but I know right to nothing
about all this arm stuff - wasn't even able to compile a cross-gcc
for it yet).  McMCC (the author of this whole work) figured out the
layout of the firmware images and mtd devices, and got D-Link stuff
(out of http://ftp.dlink.ru/pub/ADSL/GPL_source_code/ ) to build and
run on those boards...

BTW, DSL series has telnet by default (user root, password is the
one set in the admin interface, default is 'admin').  And the whole
webinterface looks very similar (but this DWL-G730AP device has some
"advanced" controls for the wireless component which are absent in
my DSL-G604T).

/mjt
