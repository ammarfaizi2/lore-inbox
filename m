Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTKXWyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTKXWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:54:49 -0500
Received: from p15091761.pureserver.info ([217.160.107.39]:39859 "HELO
	mail.keleos.net") by vger.kernel.org with SMTP id S261539AbTKXWys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:54:48 -0500
Date: Mon, 24 Nov 2003 23:55:39 +0100
From: Michael Holzt <kju@fqdn.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [ACPI] RE: Toshiba ACPI battery status - ACPI errors
Message-ID: <20031124225539.GA22718@fqdn.org>
References: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect this is a known issue with AML code from Toshiba. 

Sorry, but unfortunately your guess is wrong (would have been too easy). A
few days ago i reported about the Tecra S1 problems on the acpi-devel list
as well, maybe you missed my post, which can be found in the archives here:

  http://sourceforge.net/mailarchive/forum.php?thread_id=3511931&forum_id=6102

Included was a link to the disassembled dsdt, which can be found here:

  http://www.kju.de/data/dsdt.dsl

As you can see, the _STA-Methods of both BAT0 and BAT1 do proper return
calls. I'm sorry, but i'm do not have any knowledge about acpi or dsdts to
debug this myself. The DSDT has some other errors as well.

It is somewhat strange, that toshiba as one of the core members of ACPI
seems to be unable to provide sane DSDTs for years now. Something is real
wrong with this company.

Regards
Michael

-- 
Michael Holzt, DL3KJU, kju@fqdn.org, kju@debian.org, kju@IRCNet
