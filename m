Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVLCCRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVLCCRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVLCCRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:17:08 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:25578 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751153AbVLCCRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:17:06 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 03 Dec 2005 03:19:05 +0100
References: <5eVqw-2ug-61@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EiMzS-0001b7-0z@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Sato <sho@bsd.tnes.nec.co.jp> wrote:

> 1. Change the type of inode.i_blocks and kstat.blocks from unsigned
> long to unsigned long long.

I think the u64 data type should be used. ¢¢
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
