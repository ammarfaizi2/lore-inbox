Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbVHPV22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbVHPV22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVHPV22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:28:28 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:43679 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932733AbVHPV21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:28:27 -0400
Mime-Version: 1.0 (Apple Message framework v733)
Content-Transfer-Encoding: 7bit
Message-Id: <83B69EC3-8677-4199-BDDB-375AE708234C@freescale.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel list <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: asm/segment.h?
Date: Tue, 16 Aug 2005 16:28:35 -0500
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at some architectures it appears that asm/uaccess.h should be  
used instead of asm/segment.h.  Is this generally true that code in  
segment.h should be moved into uaccess.h or is it still valid for an  
architecture to have segment.h?

I'm cleaning up arch/ppc and arch/ppc64 and was wondering about  
everyone else.

- kumar
