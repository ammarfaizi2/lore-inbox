Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUJMP5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUJMP5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUJMP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:57:14 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59849 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269373AbUJMP5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:57:13 -0400
Subject: Re: PATCH: IDE generic tweak
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@linux.kernel.org
In-Reply-To: <20041013154916.GA6832@havoc.gtf.org>
References: <1097677476.4764.9.camel@localhost.localdomain>
	 <20041013153152.GA5458@havoc.gtf.org>
	 <1097678363.4696.16.camel@localhost.localdomain>
	 <20041013154916.GA6832@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097679269.4696.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Oct 2004 15:54:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-13 at 16:49, Jeff Garzik wrote:
> nVidia for example specifically wanted it because future __SATA__
> hardware will appear at the legacy IDE addresses, and end users were
> requesting for similar reasons.

Guess we need a pair of options with similar names to specify who
grabs the generic devices. That should be fine because it never wants
to be automatic anyway

