Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUJVUhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUJVUhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUJVUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:34:37 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3976 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267841AbUJVUaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:30:24 -0400
Date: Fri, 22 Oct 2004 22:28:51 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch netdev-2.6 0/2] r8169: vlan hwaccel fixes
Message-ID: <20041022202851.GB4216@electric-eye.fr.zoreil.com>
References: <20041022005737.GA1945@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022005737.GA1945@tuxdriver.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville <linville@tuxdriver.com> :
[...]
> Patch 1:
> 
> The return value of rtl8169_tx_vlan_tag() is not being
> endian-swapped to little endian.  The hardware registers are little
> endian, even though the vlan tag value in this register (16-bits only)
> is big endian -- confusing!  Anyway, I'll be posting a follow-up patch
> to correct this.

Oops.

> Patch 2:
[nice explanation]

Any objection against me replacing the actual comment of patch #2 (i.e.
"why" instead of "how") and splitting the "if ((tp->>vlgrp = grp))" over
two lines ?

--
Ueimor
