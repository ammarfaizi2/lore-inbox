Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTD1TxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbTD1TxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 15:53:05 -0400
Received: from bgp01015244bgs.rosvle01.mi.comcast.net ([68.41.215.65]:52023
	"EHLO bgp01015244bgs.rosvle01.mi.comcast.net") by vger.kernel.org
	with ESMTP id S261260AbTD1TxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 15:53:03 -0400
Subject: Re: Question regarding Intel i845 chipset.
From: Chris Smith <chris@realcomputerguy.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1051560315.13295.5.camel@neitsche.realcomputerguy.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Apr 2003 16:05:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003 19:30:20 +0200, Alan Cox wrote:

> No.
> 
> Not all BIOS vendors get the tables right however.

Recently compiled 2.4.21-rc1 on two systems with Intel boards, one an
i850 based board where there were no problems with the APIC being
enabled (as it was also with an earlier kernel) but an i845 based board
(Intel D845PT, latest BIOS) would not enable the APIC (all XT-PIC in
/proc/interrupts) until I applied the -ac3 patch, even though the APIC
has worked fine under that other OS.

Chris Smith



