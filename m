Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbVBEBSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbVBEBSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbVBEBLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:11:42 -0500
Received: from imap.gmx.net ([213.165.64.20]:30604 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266481AbVBEBJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:09:51 -0500
X-Authenticated: #26200865
Message-ID: <42041D01.3010200@gmx.net>
Date: Sat, 05 Feb 2005 02:10:25 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       Pavel Machek <pavel@ucw.cz>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>	 <9e47339105020321031ccaabb@mail.gmail.com> <1107528057.6191.128.camel@gonzales>
In-Reply-To: <1107528057.6191.128.camel@gonzales>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel schrieb:
> Le vendredi 04 février 2005 à 00:03 -0500, Jon Smirl a écrit :
> 
>>Doing this in user space lets you have two reset
>>programs, vm86 and emu86 for non-x86 machines.
> 
> 
> Perhaps only emu86 should be used, to have a well-debugged codepath on
> all archs (amd64, ppc, ...)
> As it's usermode, the code size is less of a problem.

Well, if it has to live in initramfs, it better be really small.
An initramfs with a size of 8 megabytes isn't going to make you
many friends.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
