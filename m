Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbTGOHjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbTGOHjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:39:07 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:53969 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266799AbTGOHjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:39:03 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "B. D. Elliott" <bde@nwlink.com>
Date: Tue, 15 Jul 2003 17:53:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16147.45801.812885.479853@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Where's the Beep?" (PCMCIA/vt_ioctl-s)
In-Reply-To: message from B. D. Elliott on Tuesday July 15
References: <20030715074826.EF8F46DC14@smtp3.pacifier.net>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 15, bde@nwlink.com wrote:
> On my old DELL LM laptop the -2.5 series no longer issues any beeps when
> a card is inserted.  The problem is in the kernel, as the test program
> below (extracted from cardmgr) beeps on -2.4, but not on -2.5.

CONFIG_INPUT_PCSPKR

needs to be =y or =m and the module loaded.

NeilBrown
