Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUI3N7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUI3N7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUI3N7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:59:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55437 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269262AbUI3Nzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:55:49 -0400
Subject: Re: [PATCH] overcommit symbolic constants
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <UTC200409301341.i8UDfRi02421.aeb@smtp.cwi.nl>
References: <UTC200409301341.i8UDfRi02421.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096548791.19269.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Sep 2004 13:53:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-30 at 14:41, Andries.Brouwer@cwi.nl wrote:
> Played a bit with overcommit the past hour.
> Am not entirely satisfied with the no overcommit mode 2 -
> programs segfault when the system is close to that boundary.

Not really a suprise. Very few programs handle stack growth faults.
Hence the docs comment about mmapping stacks privately for critical
code.

