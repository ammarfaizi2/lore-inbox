Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUHFBCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUHFBCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 21:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUHFBCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 21:02:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37567 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268039AbUHFBBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 21:01:51 -0400
Subject: Re: /dev/hdl not showing up because
	of	fix-ide-probe-double-detection patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Andrew Morton <akpm@osdl.org>, Tupshin Harper1 <tupshin@tupshin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4112BCEE.10102@rtr.ca>
References: <411013F7.7080800@tupshin.com> <4111651E.1040406@tupshin.com>
	 <20040804224709.3c9be248.akpm@osdl.org>
	 <1091720165.8041.4.camel@localhost.localdomain>  <4112BCEE.10102@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091750310.8418.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 06 Aug 2004 00:58:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 00:04, Mark Lord wrote:
>  >Two disks are not permitted to have the same serial number.
> 
> Sure they are.
> 
> But the combination of MODEL::SERIALNO is guaranteed to be unique.

Thats what the code is intended to check. I'm assuming I've screwed up
the logic a little somewhere. Once I've got the ident info it should be
blindingly obvious

