Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274710AbRIYXVs>; Tue, 25 Sep 2001 19:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274717AbRIYXVi>; Tue, 25 Sep 2001 19:21:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57729 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274710AbRIYXV1>; Tue, 25 Sep 2001 19:21:27 -0400
Message-Id: <200109252321.f8PNLfn10095@crg8.beaverton.ibm.com>
X-Mailer: exmh version 2.0.2 2/24/98
To: linux-kernel@vger.kernel.org
cc: barkal@us.ibm.com
Subject: shmdt() always returns success
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 16:21:40 PDT
From: Judy Barkal <barkal@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason we shouldn't have shmdt() return failures - either from 
the call to do_munmap() or because the shmaddr is invalid?

If nobody objects, I can create a patch for this.

Judy

