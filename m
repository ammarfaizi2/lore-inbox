Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUCAT47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUCAT47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:56:59 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:8321
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S261418AbUCAT45 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:56:57 -0500
Message-ID: <20040301195656.32036.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: linux-kernel@vger.kernel.org
cc: dag@newtech.fi
Subject: __attribute_const__  creates problems in 2.6
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 01 Mar 2004 21:56:56 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

just compiled k3b and cdrtools here and ran into a problem
with my system not understanding __attribute_const__  when
including linux/cdrom.h.

#define:ing __attribute_const__  as empty before including
solved the problem.

I wonder if it is just me or if this should be fixed by including some
other file as well ?

BRGDS

-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


