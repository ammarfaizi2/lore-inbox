Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTEHLuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTEHLuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:50:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34953 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261387AbTEHLuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:50:06 -0400
Date: Thu, 08 May 2003 03:54:42 -0700 (PDT)
Message-Id: <20030508.035442.85387749.davem@redhat.com>
To: hch@infradead.org
Cc: romieu@fr.zoreil.com, chas@locutus.cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE
 he_init_one()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030508060640.A24325@infradead.org>
References: <200305071813.h47IDpc9010906@hera.kernel.org>
	<20030508010146.A20715@electric-eye.fr.zoreil.com>
	<20030508060640.A24325@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Thu, 8 May 2003 06:06:40 +0100
   
   Who reviewed this driver before inclusion?

This one goes all the way back to when Werner still maintained
the ATM layer, and frankly back then we didn't give a crap
about these issues as much as we do now.
