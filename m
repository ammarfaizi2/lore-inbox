Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUFVMF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUFVMF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUFVMF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:05:26 -0400
Received: from web13906.mail.yahoo.com ([216.136.175.69]:2061 "HELO
	web13906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262927AbUFVMFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:05:17 -0400
Message-ID: <20040622120515.28636.qmail@web13906.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Tue, 22 Jun 2004 05:05:15 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Problems with 2.6.7-mm1 on HP Omnibook 6100
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>after going from 2.6.6-mm5 to 2.6.7-mm1, I see the following problems.
>
>a) System hangs at boot. Local APIC related. This is a known problem
on
>the OB, but could be avoided by specifying "nolapic" in 2.6.6-mm5.
With
>2.6.7-mm1 I have to specify "acpi=off", or apply the following patch
>from Len:

 just out of curiosity I checked out 2.6.7 vanilla. The problem does
not exist. Giving "nolapic" on the boot line is equivalent to Len's
patch.

>b) The system does not shut down (or reboot) any more. The last output
>is:
>
>ISDN-subsystem unloaded
>
>Sometimes CTRL-ALT-DEL helps to bring the system down, sometimes I
>just have to reset it.

 this also does not happen on vanilla 2.6.7.

Cheers
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
