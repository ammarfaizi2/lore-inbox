Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVG1J5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVG1J5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVG1J5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:57:49 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:15573 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261345AbVG1J5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:57:49 -0400
Date: Thu, 28 Jul 2005 11:57:24 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: build system changed? cannot build any module
Message-ID: <20050728095724.GA32691@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

I cannot build any external module (acerhk, pwc), in all the cases it
the make run looks similar:
make -C /lib/modules/`uname -r`/build SUBDIRS=/src/hotkey/acerhk-0.5.25 modules
make[1]: Entering directory `/usr/src/linux-2.6.13-rc3-mm2' scripts/Makefile.build:14: /usr/src/linux-2.6.13-rc3-mm2//src/hotkey/acerhk-0.5.25/Makefile: No such file or directory
make[2]: *** No rule to make target `/usr/src/linux-2.6.13-rc3-mm2//src/hotkey/acerhk-0.5.25/Makefile'.  Stop.

Has something fundamentally changed in the way external modules should
be build?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
`My doctor says that I have a malformed public-duty gland
and a natural deficiency in moral fibre, and that I am
therefore excused from saving Universes.'
                 --- Ford's last ditch attempt to get out of helping
                 --- Slartibartfast.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
