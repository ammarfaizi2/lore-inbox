Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbTENUuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTENUuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:50:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47518 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262816AbTENUub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:50:31 -0400
Date: Wed, 14 May 2003 14:02:57 -0700 (PDT)
Message-Id: <20030514.140257.26294164.davem@redhat.com>
To: greg@kroah.com
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030514205949.GA3945@kroah.com>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil>
	<20030514205949.GA3945@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Wed, 14 May 2003 13:59:49 -0700
   
   Any reason to not just use a struct device here?  This is a device,
   right?  Or at the very least, a kobject would be acceptable.

As I understand it, it's a device private for a struct netdevice.

It is referenced much differently, I don't think using kobject
is as appropriate as one might expect.
