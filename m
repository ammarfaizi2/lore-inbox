Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWJMQ1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWJMQ1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWJMQ1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:27:12 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:30626 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751668AbWJMQ1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:27:11 -0400
Date: Fri, 13 Oct 2006 18:26:47 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061013162647.GH3039@mail.muni.cz>
References: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com> <452F1142.3000400@intel.com> <20061013091608.GH18163@mail.muni.cz> <1160753436.3000.497.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1160753436.3000.497.camel@laptopd505.fenrus.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 05:30:36PM +0200, Arjan van de Ven wrote:
> 
> > For i965 chipsets, the BIOS is *a lot* buggy :(
> 
> have you run the Linux firmware test kit on it?
> 
> see http://www.linuxfirmwarekit.org

I did. It complains about EDD as fatal error, some warnings about ACPI and
MMCONFIG, otherwise it says passed.

However, I suspect another BIOS bug:
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not
present [20060707]
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not
present [20060707]

(BIOS announces 4 processors while 1 dual core is present).

-- 
Luká¹ Hejtmánek
