Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUJKJMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUJKJMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUJKJMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:12:08 -0400
Received: from oceanite.ens-lyon.fr ([140.77.1.22]:12595 "EHLO
	oceanite.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S268730AbUJKJME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:12:04 -0400
Message-ID: <416A4D67.9070108@ens-lyon.fr>
Date: Mon, 11 Oct 2004 11:07:51 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> (The ACPI update fixes broken AML with implied returns, and in particular
> the Compaq Evo notebook fan control. Yay! Guess who has one..)

Well, I have one (N600c).
What am I supposed to see ? Is there anything special to do ?

I don't know exactly how fan control is supposed to be fixed.
Automatic wakeup/stop of these fans depending on the temperature
was already working.
Manual stopping of any fan (by writing into /proc/acpi/fan/*/state)
still doesn't work (don't know whether it's supposed to work or not).

By the way, I still see these errors during the boot, don't know if it's
supposed to be fixed :

  psparse-1133: *** Error: Method execution failed
[\_SB_.C03E.C053.C0D1.C12E] (Node e7f9a3a8), AE_AML_UNINITIALIZED_LOCAL
  psparse-1133: *** Error: Method execution failed
[\_SB_.C03E.C053.C0D1.C13D] (Node e7f9bd68), AE_AML_UNINITIALIZED_LOCAL
  psparse-1133: *** Error: Method execution failed [\_SB_.C19F._BTP]
(Node e7fa3348), AE_AML_UNINITIALIZED_LOCAL

Regards,
Brice Goglin



