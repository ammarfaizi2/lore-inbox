Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTIDJbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTIDJbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:31:39 -0400
Received: from hell.org.pl ([212.244.218.42]:43268 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264881AbTIDJbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:31:37 -0400
Date: Thu, 4 Sep 2003 11:33:46 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Nils Faerber <nils@kernelconcepts.de>
Cc: "Brown, Len" <len.brown@intel.com>,
       Martin Mokrejs <mmokrejs@natur.cuni.cz>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] RE: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Message-ID: <20030904093346.GA14506@hell.org.pl>
Mail-Followup-To: Nils Faerber <nils@kernelconcepts.de>,
	"Brown, Len" <len.brown@intel.com>,
	Martin Mokrejs <mmokrejs@natur.cuni.cz>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com> <20030904085315.GA29773@hell.org.pl> <1062667556.13465.37.camel@idoru.kc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1062667556.13465.37.camel@idoru.kc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Nils Faerber:
> Just FYI...
> I have kernel 2.4.22 + swsusp 1.1-rc7 running without problems on the
> very same machine (Asus L3800C, BIOS 121a).
[...]
> One point that proofs to be a good idea is to remove any unnecessary
> drivers before suspending, like USB, Firewire and ethernet and to
> re-insert them afterwards. The attached script does this.

Actually, most modules do not need to be unloaded. I don't know about
firewire (I don't use it), but certainly 8139too contains proper
suspend/resume support, I even had no problems suspending with yenta_socket
and orinoco_cs card. As of now: no modules unloading at all. Anyway, the
crash is not swsusp related.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
