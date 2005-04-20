Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVDTRlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVDTRlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVDTRkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:40:09 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:8065 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261769AbVDTRi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:38:27 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Kernel page table and module text
To: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 20 Apr 2005 19:37:46 +0200
References: <3V6qt-2ve-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DOJ92-0002I4-E7@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allison <fireflyblue@gmail.com> wrote:

> I want to find where each module is loaded in memory by traversing the
> module list . Once I have the address and the size of the module, I
> want to read the bytes in memory of the module and hash it to check
> it's integrity.

JFTR: This may work against random memory corruption, but it will fail for
detecting attacks.
-- 
Top 100 things you don't want the sysadmin to say:
54. Uh huh......"nu -k $USER".. no problem....sure thing...

