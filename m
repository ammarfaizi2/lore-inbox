Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUDOM23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 08:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDOM23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 08:28:29 -0400
Received: from magic.adaptec.com ([216.52.22.17]:62925 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262902AbUDOM22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 08:28:28 -0400
Date: Thu, 15 Apr 2004 18:02:04 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: linux-kernel@vger.kernel.org
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
Subject: why change_page_attr on x86 uses __flush_tlb_all
Message-ID: <Pine.LNX.4.44.0404151757560.17679-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Apr 2004 12:28:23.0374 (UTC) FILETIME=[24D0DEE0:01C422E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I would expect __flush_tlb_one (for each page) as a better choice.
It'll be nice if someone can hoghlight on  why __flush_tlb_all is used.
The kernel version I am referring from is 2.4.18-14

Thanx,
tomar


PS: Please CC to my email-id as I'm not able to access the list.



-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

