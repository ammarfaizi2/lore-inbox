Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUHZCGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUHZCGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 22:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUHZCGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 22:06:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:10685 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266730AbUHZCGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 22:06:05 -0400
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <10934733881970@kroah.com>
References: <10934733881970@kroah.com>
Content-Type: text/plain
Message-Id: <1093485846.3054.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 12:04:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 08:36, Greg KH wrote:
> ChangeSet 1.1873, 2004/08/25 13:21:22-07:00, khali@linux-fr.org
> 
> [PATCH] I2C: keywest class
> 
> This is needed for iBook2 owners to be able to use their ADM1030
> hardware monitoring chip. Successfully tested by one user.

Vetoed until I get a proper explanation on what that is supposed to do,
I don't want random stuff mucking around the i2c busses on those machines,
only specifically written drivers for the chips in there.

Please, do NOT apply.

Ben.


