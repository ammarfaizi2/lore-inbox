Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTEXSyB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 14:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTEXSyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 14:54:01 -0400
Received: from mail.gmx.net ([213.165.65.60]:13413 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263202AbTEXSyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 14:54:00 -0400
Message-ID: <3ECFC2D6.2020007@gmx.net>
Date: Sat, 24 May 2003 21:07:02 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-smp@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [RFC] Fix NMI watchdog documentation
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Documentation/nmi_watchdog.txt does not say which CONFIG_XYZ option has
to be enabled to use the NMI watchdog, but it mentions that IO-APIC is
somewhat related.

Documentation/Configure.help is equally unclear. The NMI watchdog is
mentioned as related to CONFIG_SMP, and the help text for
CONFIG_X86_UP_APIC says: "The local APIC supports [..] the NMI watchdog"
That does not necessarily mean that NMI is compiled in once local APIC
support is selected.

Can someone please shed some light on this issue? I'm willing to create
a patch to fix the docs once I know if the NMI watchdog is compiled in
alsways or on what it depends.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

