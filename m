Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271418AbTG2MF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTG2MF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:05:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61641 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271418AbTG2MFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:05:50 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Date: Tue, 29 Jul 2003 22:05:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16166.25350.70923.742360@gargle.gargle.HOWL>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS Server running 2.6.0-test2
In-Reply-To: message from Robert L. Harris on Tuesday July 29
References: <20030729110716.GC786@rdlg.net>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 29, Robert.L.Harris@rdlg.net wrote:
> 
> 
> Just converted my nfs server to 2.6.0-test2 last night.  This morning I
> found this on my console:
> 
> {0}:/>
> Message from syslogd@camel at Tue Jul 29 00:02:30 2003 ...
> camel kernel: journal commit I/O error
> 

I'm guessing that the filesystem got an I/O error when writing to the
device.
Anything in the kernel log that might confirm or deny this?

NeilBrown
