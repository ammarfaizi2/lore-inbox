Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTAXH04>; Fri, 24 Jan 2003 02:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTAXH04>; Fri, 24 Jan 2003 02:26:56 -0500
Received: from vinland.freeshell.org ([207.202.214.139]:19196 "EHLO
	sdf.lonestar.org") by vger.kernel.org with ESMTP id <S267494AbTAXH0z>;
	Fri, 24 Jan 2003 02:26:55 -0500
Date: Fri, 24 Jan 2003 07:36:04 +0000
From: john weber <weber@sixbit.org>
To: linux-kernel@vger.kernel.org
Subject: PCMCIA 2.5 and PCI IRQ Allocation
Message-ID: <20030124073604.GA16002@sixbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: worldwideweber
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a device or resource busy error when trying to load my 
card driver (Orinoco Wireless).

I have to enable ISA in order to get pcmcia_request_irq (in cs.c) to 
allocate an IRQ. After this everything works fine.

Any comments?

 -o) j o h n  e  w e b e r
 / \ teacher, hacker, gamer, husband, and pugilist
_\_v http://weber.sixbit.org/
