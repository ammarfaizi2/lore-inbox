Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290644AbSBLAgL>; Mon, 11 Feb 2002 19:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290645AbSBLAgB>; Mon, 11 Feb 2002 19:36:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64645 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290644AbSBLAft>;
	Mon, 11 Feb 2002 19:35:49 -0500
Date: Mon, 11 Feb 2002 16:33:58 -0800 (PST)
Message-Id: <20020211.163358.55509606.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, COTTE@de.ibm.com, rgooch@ras.ucalgary.ca
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020211161259.E21300@flint.arm.linux.org.uk>
In-Reply-To: <OFA3A51DAC.14854039-ONC1256B5D.0045F62F@de.ibm.com>
	<20020211161259.E21300@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Mon, 11 Feb 2002 16:12:59 +0000
   
   Isn't it about time we made the bitops take an unsigned long pointer
   argument, rather than a void pointer to catch errors like this?

No, I tried to do that once, but the casts become stupid
and ugly.
