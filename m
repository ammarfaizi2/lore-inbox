Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFDMi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFDMi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 08:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVFDMi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 08:38:27 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:5552 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261337AbVFDMiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 08:38:25 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
To: Vivek Goyal <vgoyal@in.ibm.com>, Alan Stern <stern@rowland.harvard.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       greg@kroah.com, Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Reply-To: 7eggert@gmx.de
Date: Sat, 04 Jun 2005 14:38:20 +0200
References: <4bExX-3uT-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DeXuv-0000fH-LZ@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:

> Hi Alan, I know very little about consoles and their working.
> I had a question. Even if console is being managed by platform firmware, in
> initial states of booting, does it require interrupts to be enabled at
> VGA contorller (at least for the simple text mode).

VGA does not use interrupts for normal operation, even in graphics mode.
It can generate them for synchronisation.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
