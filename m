Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317271AbSGCX2q>; Wed, 3 Jul 2002 19:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317276AbSGCX2p>; Wed, 3 Jul 2002 19:28:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317271AbSGCX2p>;
	Wed, 3 Jul 2002 19:28:45 -0400
Subject: Re: Cyrix IRQ routing is wrong?
To: proski@gnu.org (Pavel Roskin)
Date: Thu, 4 Jul 2002 00:31:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, dhinds@sonic.net (David Hinds)
In-Reply-To: <Pine.LNX.4.44.0207011814070.18831-100000@marabou.research.att.com> from "Pavel Roskin" at Jul 01, 2002 07:50:14 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Ptae-0002Ir-00@www.linux.org.uk>
From: Alan Cox <alan@www.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The existing code uses the upper nibble in the same byte for lower pirq,
> but it seems that we should start with the lower nibble for EM-350A.

On all my boards its upper first and the current code works while the 
patch you have hangs the box
