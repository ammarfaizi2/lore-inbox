Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbUKEPNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbUKEPNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbUKEPNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:13:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48324 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262679AbUKEPND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:13:03 -0500
Subject: Re: HPT372 (on Lanparty pro875) on 2.6.8/9 not working
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: p1234@p1.be
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <2169.81.83.13.5.1099605723.squirrel@www.vbchosting.be>
References: <2169.81.83.13.5.1099605723.squirrel@www.vbchosting.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099663798.5630.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 05 Nov 2004 14:10:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-04 at 22:02, p1234@p1.be wrote:
> Consistently, the two harddisks show up instead of the "virtual" mirror
> disk, with all problems that follow (duplicate labels etc).

Correct hpt366 does not directly support the vendor software raid mode,
you need the "dmraid" tool to configure that for user space.

