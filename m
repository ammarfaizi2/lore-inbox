Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279818AbRLDD0c>; Mon, 3 Dec 2001 22:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278959AbRLDDYd>; Mon, 3 Dec 2001 22:24:33 -0500
Received: from [210.176.202.14] ([210.176.202.14]:53899 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S280434AbRLDDXL>; Mon, 3 Dec 2001 22:23:11 -0500
Subject: VM changes since 2.4.14
From: David Chow <davidchow@rcn.com.hk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 11:23:07 +0800
Message-Id: <1007436187.9000.15.camel@star9.planet.rcn.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

In mm/page_io.c the function rw_swap_page_base(), since 2.4.14 the
rw==WRITE case is missing. Does that mean rw_swap_page_base will never
be called with rw==WRITE? That is rw_swap_page_base will never used to
write a swap page? Then where does the swap write goes? Also the auto 
int "zone_used" is never used twice and it seems useless, it is sitting
there and wasting for memory. The 2.4.16 still keep the "int zone_used"
which is totally usless and is a unused variable.

DC

