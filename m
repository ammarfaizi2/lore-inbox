Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268147AbTCFRO1>; Thu, 6 Mar 2003 12:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268153AbTCFRO1>; Thu, 6 Mar 2003 12:14:27 -0500
Received: from fmr01.intel.com ([192.55.52.18]:44778 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268147AbTCFROZ>;
	Thu, 6 Mar 2003 12:14:25 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847E96CCB@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: daveman@bellatlantic.net, linux-kernel@vger.kernel.org
Subject: RE: Missing keypress when ACPI enabled
Date: Thu, 6 Mar 2003 09:24:34 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: daveman@bellatlantic.net [mailto:daveman@bellatlantic.net] 
> Since about 2.5.60, the first 2.5 kernel that has 
> built/booted for me, I've noticed X/Kscreensaver fails to 
> capture a keystroke after about 20 minutes of inactivity, in 
> the password login prompt. It is only the first keypress that 
> is lost, all later keypresses work fine. I believe I've 
> narrowed it down to an interaction with having ACPI enabled, 
> as booting the kernel with 'acpi=off' seems to make the 
> problem go away. I've attached dmesg and .config output. 
> Please let me know if I can assist further.

Aha, you have an IBM A20 (or similar). You are not the first one to
report this, and indeed this happens on my T20, even under Windows.
Given that, I would suspect this is a side effect of some unknown IBM
BIOS enhancement, so I don't know what we can do without IBM telling us
more about what's going on.

Regards -- Andy
