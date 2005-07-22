Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVGVOWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVGVOWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVGVOWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:22:48 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57804 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262094AbVGVOWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:22:48 -0400
Subject: Re: IDE disk and HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Tennert <O.Tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200507221417.04640.tennert@science-computing.de>
References: <200507221417.04640.tennert@science-computing.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 15:47:18 +0100
Message-Id: <1122043638.9478.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do I interpret it right that the following is done in the above function:

Aside from the version in most kernels being buggy yes

> My question is now: why is an HPA disabled i.e. disprotected when detected? 
> Why not let the HPA alone, because a certain set of disk sectors shall not be 
> accessible by the OS?

Because the HPA is most commonly used to hide all but a fraction of a
disk to work with older BIOSes.
