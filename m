Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132919AbRDEPLF>; Thu, 5 Apr 2001 11:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132920AbRDEPK4>; Thu, 5 Apr 2001 11:10:56 -0400
Received: from virtualro.ic.ro ([194.102.78.138]:39698 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S132919AbRDEPKr>;
	Thu, 5 Apr 2001 11:10:47 -0400
Date: Thu, 5 Apr 2001 18:10:17 +0300 (EEST)
From: Jani Monoses <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: ERESTARTSYS question.
Message-ID: <Pine.LNX.4.10.10104051801410.29033-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
although the comments in errno.h say that ERESTARTSYS should not be seen
by userland,many drivers seam to return it from their
file_operations.Should glibc convert this errno so that the user program
sees something meaningful?Because it does not.Is EINTR not a better errno 
to return from the drivers?

Thanks. 



