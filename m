Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267477AbTANGhU>; Tue, 14 Jan 2003 01:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTANGhU>; Tue, 14 Jan 2003 01:37:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18850 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267477AbTANGhS>;
	Tue, 14 Jan 2003 01:37:18 -0500
Date: Mon, 13 Jan 2003 22:36:41 -0800 (PST)
Message-Id: <20030113.223641.61538045.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Update arm implementation of DMA API to include GFP_
 flags
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200301140606.h0E668L16950@hera.kernel.org>
References: <200301140606.h0E668L16950@hera.kernel.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
   Date: Mon, 13 Jan 2003 16:30:18 +0000

   ChangeSet 1.930.8.3, 2003/01/13 10:30:18-06:00, jejb@raven.il.steeleye.com
   
   	Update arm implementation of DMA API to include GFP_ flags
   
Is this really safe?  Maybe ARM needs to use GFP_ATOMIC all the
time for a specific reason, such as where and how it maps the
cpu side mappings of the memory?
