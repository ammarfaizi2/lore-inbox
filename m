Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTGGGcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbTGGGcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:32:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39079
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264762AbTGGGcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:32:10 -0400
Subject: Re: ATI IGP Support and System Freeze when running hwclock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: diemumiee@gmx.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030706232315.GA32461@durix.hallo.net>
References: <20030706144114.GA23881@durix.hallo.net>
	 <1057513936.1029.5.camel@dhcp22.swansea.linux.org.uk>
	 <20030706232315.GA32461@durix.hallo.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057560242.2412.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jul 2003 07:44:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-07 at 00:23, diemumiee@gmx.de wrote:
> I installed 2.4.21-ac with acpi. Acpi works great, but the whole system
> freezes when i try to run "hwclock --adjust --localtime". The module
> rtc.o gets loaded before the call to hwclock. 

Its something about ACPI combined with ALi real time clocks. Its still
a mystery. Dropping the rtc module from the build should fix it

