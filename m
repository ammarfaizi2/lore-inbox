Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262704AbSJCAMX>; Wed, 2 Oct 2002 20:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262706AbSJCAMX>; Wed, 2 Oct 2002 20:12:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10444 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262704AbSJCAMV>;
	Wed, 2 Oct 2002 20:12:21 -0400
Date: Wed, 02 Oct 2002 17:10:42 -0700 (PDT)
Message-Id: <20021002.171042.42890215.davem@redhat.com>
To: linux_learning@yahoo.co.uk
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: this code does not get called in dev.c so do we need it?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021002140236.53405.qmail@web13107.mail.yahoo.com>
References: <20021002140236.53405.qmail@web13107.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fast routing, although not implemented in any in-tree drivers,
does get used by some people who have hacked up drivers to support
this.

It allows IPv4 routing to occur right at the level of the device
driver, it directly pushes an input packet to the output routine
of the destination device all without leaving the driver.

This code is used.
