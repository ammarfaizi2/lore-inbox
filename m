Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVCKDzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVCKDzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVCKDyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:54:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:31960 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261709AbVCKDsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:48:18 -0500
Subject: Re: pci_fixup_video() bogosity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <9e47339105031019393ce91f60@mail.gmail.com>
References: <1110256709.13607.248.camel@gaston>
	 <9e473391050307215776f5c06@mail.gmail.com>
	 <1110266266.13607.264.camel@gaston>
	 <9e47339105031019393ce91f60@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 14:42:58 +1100
Message-Id: <1110512578.32524.341.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 22:39 -0500, Jon Smirl wrote:
> Patch to make detection of boot video device more robust. Should I
> leave the printk in?

Hrm... yes, but make it KERN_DEBUG.

Ben.


