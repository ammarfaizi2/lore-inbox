Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVDSCOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVDSCOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 22:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVDSCOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 22:14:06 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:10903
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S261272AbVDSCOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 22:14:03 -0400
Date: Mon, 18 Apr 2005 19:12:38 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hostap@shmoo.com, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: 2.6.12-rc2-mm3: hostap: do not #include .c files
Message-ID: <20050419021238.GG8267@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	hostap@shmoo.com, jgarzik@pobox.com, netdev@oss.sgi.com
References: <20050411012532.58593bc1.akpm@osdl.org> <20050419020312.GR5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419020312.GR5489@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 04:03:12AM +0200, Adrian Bunk wrote:

> drivers/net/wireless/hostap/hostap.c:#include "hostap_crypt.c"

> Please do not #include .c files.

A tested patch would be appreciated.. ;-)

> A proper separation in a .c file and a header file is the better 
> solution.

Agreed and this is on my to-do list, but not very high on it. Some of
these would be relatively easy to fix, but the hardware specific ones
(different register offsets for PC Card/PLX/PCI) would require quite a
bit of changes to get rid of this.

-- 
Jouni Malinen                                            PGP id EFC895FA
