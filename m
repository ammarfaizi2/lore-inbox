Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVCKTZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVCKTZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVCKTVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:21:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15001 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261317AbVCKTLr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:11:47 -0500
Subject: Re: select() doesn't respect SO_RCVLOWAT ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felix Matathias <felix@nevis.columbia.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503101645190.29442@shang.nevis.columbia.edu>
References: <Pine.LNX.4.61.0503101645190.29442@shang.nevis.columbia.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110568180.17740.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Mar 2005 19:09:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-10 at 21:58, Felix Matathias wrote:
> Dear all,
> 
> I am running a 2.4.21-9.0.3.ELsmp #1 kernel and I can setsockopt and 
> getsockopt correctly the SO_RCVLOWAT option

The only value the code at least used to support was setting it to 1.
Are you sure you are actually setting/checking ok ?

