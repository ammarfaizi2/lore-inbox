Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262930AbTCSFFA>; Wed, 19 Mar 2003 00:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbTCSFFA>; Wed, 19 Mar 2003 00:05:00 -0500
Received: from rakshak.ishoni.co.in ([164.164.83.140]:44356 "EHLO
	arianne.in.ishoni.com") by vger.kernel.org with ESMTP
	id <S262930AbTCSFE6>; Wed, 19 Mar 2003 00:04:58 -0500
Subject: FIXMAP
From: Amol Kumar Lad <amolk@ishoni.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Mar 2003 10:46:13 -0500
Message-Id: <1048088779.5155.30.camel@amol.in.ishoni.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What will happen if one does

vaddr = fix_to_virt(0);
virt_to_fix(vaddr);

As enum fixed_address can contain 0 index also so fix_to_virt will
return FIXADDR_TOP which will result in a BUG() in virt_to_fix..

Am I missing something ?

Please cc me... I am reading 2.5.47...

Thanks
Amol




