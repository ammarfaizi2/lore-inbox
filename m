Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266089AbUFDXS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266089AbUFDXS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUFDXPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:15:11 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:153 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266068AbUFDXNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:13:47 -0400
Message-ID: <40C101D5.3050101@blue-labs.org>
Date: Fri, 04 Jun 2004 19:12:21 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040412
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [boot hang] 2.6.7-rc2, VIA VT8237
References: <40C0D8FE.7040009@blue-labs.org> <200406042238.04100.bzolnier@elka.pw.edu.pl> <40C0DEC0.90805@blue-labs.org>
In-Reply-To: <40C0DEC0.90805@blue-labs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both 2.6.5 and 2.6.7 will boot using the GENERIC IDE driver.  I haven't 
yet gotten any kernel to not lock up using the VIA driver.

On another note, I can't get ANY network card to work in this machine 
other than with the gentoo LiveCD;  tulip, 3com, RTL, eepro, smc..

The e100 driver even gives me this nonsense: "SIOCSIFFLAGS: Connection 
timed out" when setting the interface up.

The eepro100 driver says it can't initialize the 82557 and check that 
the card is in a bus-master capable slot.  Self test failed.

This is silly.  The same hardware all works with the LiveCD kernel, no 
boot options.

david

