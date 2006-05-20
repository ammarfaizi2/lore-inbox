Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWETTFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWETTFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 15:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWETTFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 15:05:42 -0400
Received: from jacks.isp2dial.com ([64.142.120.55]:16132 "EHLO
	jacks.isp2dial.com") by vger.kernel.org with ESMTP id S932370AbWETTFl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 15:05:41 -0400
From: John Kelly <jak@isp2dial.com>
To: linux-kernel@vger.kernel.org
Subject: vmi vs. xen
Date: Sat, 20 May 2006 15:05:40 -0400
Message-ID: <200605201905.k4KJ5dsg015933@isp2dial.com>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Hard2Crack: 0.001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to:

http://news.com.com/2100-7344_3-6061019.html?part=rss&tag=6061019&subj=news

> Part of the problem has stemmed from branding issues,
> Pratt said. "They object to putting patches into Linux
> having the 'Xen' prefix on all the function names.
> We're miffed about it being called VMI, since we did
> the hard work of interfaces and defining the patches,"

vzx = VirtualiZation Xen
vzx = Vmware virtualiZation linuX
vzx = VirtualiZation eXternal

So 'vzx' can represent Xen, VMware, or any generic 'eXternal' VM.  And
for the openvz/vserver folks:

vzi = VirtualiZation Internal (or In-kernel)

Grepping 2.6.16 for case-insensitive 'vzi' finds 0 matches.

Grepping 2.6.16 for case-insensitive 'vzx' finds 12 matches to 'movzx'
instruction in ./arch/i386/crypto/aes-i586-asm.S.


