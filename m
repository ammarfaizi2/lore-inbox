Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbTH0Jab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTH0Jab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:30:31 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:2755 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263224AbTH0Ja3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:30:29 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 27 Aug 2003 11:30:27 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-Id: <20030827113027.64c42485.skraw@ithnet.com>
In-Reply-To: <20030827073758.GW83336@niksula.cs.hut.fi>
References: <20030729073948.GD204266@niksula.cs.hut.fi>
	<20030730071321.GV150921@niksula.cs.hut.fi>
	<Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva>
	<20030730181003.GC204962@niksula.cs.hut.fi>
	<20030827064301.GF150921@niksula.cs.hut.fi>
	<20030827073758.GW83336@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 10:37:58 +0300
Ville Herva <vherva@niksula.hut.fi> wrote:

> > Did you already try to exchange everything but the harddisks ?
> 
> No. Do you suspect faulty hardware?
> [...]
> What I had hoped for is to be able to get some information on where it hangs.
> But sysrq and nmi watchdog don't cut it...

Hm, did you try a serial console? On my side this was a big step forward.
If you experience complete hangs it may be something around hanging interrupts.
Did you play with apic/acpi etc. to try different interrupt handling? What does
your /proc/interrupts look like compared between 2.2 and 2.4 ?

Regards,
Stephan
