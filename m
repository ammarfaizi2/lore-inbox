Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVCHWGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVCHWGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVCHWGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:06:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:7090 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261580AbVCHWGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:06:06 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: xorg@freedesktop.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <1110265919.13607.261.camel@gaston>
References: <1110265919.13607.261.camel@gaston>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 09:01:44 +1100
Message-Id: <1110319304.13594.272.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minus the big fat ugly bug of scheduling with a spinlock in vga_get() of
course ... bah. Easy to fix tho. I'll post a new version later.

Ben.



