Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVDEWTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVDEWTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 18:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVDEWTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 18:19:09 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:48108 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261809AbVDEWTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 18:19:07 -0400
Date: Wed, 6 Apr 2005 00:19:03 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Message-ID: <20050405221903.GA21196@gamma.logic.tuwien.ac.at>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at> <20050405204107.GD1380@elf.ucw.cz> <20050405210041.GA16263@gamma.logic.tuwien.ac.at> <20050405211340.GF1380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050405211340.GF1380@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 05 Apr 2005, Pavel Machek wrote:
> Well, I do not have working suspend-to-RAM setup close to me... Could
> you try 2.6.12-rc1 to see if reboot problem is -mm specific or not?

2.6.12-rc2 suspends and resumes with the very same config file (well,
after running make oldconfig) without any problem.

So there is a change in -mm1 which triggers this. Should I start with
backing out bk-acpi? or anything else?

> input is known for some funky behaviour, especially with
> synaptics. Disabling cpufreq might be good idea, too...

rc2 with input compiled in and cpufreq compiled in did resume.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
THRUMSTRER (n.)
The irritating man next to you in a concert who thinks he's (a) the
conductor, (b) the brass section.
			--- Douglas Adams, The Meaning of Liff
