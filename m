Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263038AbSJBKer>; Wed, 2 Oct 2002 06:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263040AbSJBKer>; Wed, 2 Oct 2002 06:34:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11974 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263038AbSJBKep>;
	Wed, 2 Oct 2002 06:34:45 -0400
Date: Wed, 02 Oct 2002 03:32:59 -0700 (PDT)
Message-Id: <20021002.033259.10308318.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dereferencing semaphores and atomic_t's
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021002111625.B24770@flint.arm.linux.org.uk>
References: <20021002111625.B24770@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Wed, 2 Oct 2002 11:16:26 +0100

   Do we really allow this type of layering violation?
   
No, it should be killed :-)

   (There appear to be some circumstances when obtaining the semaphore count is
   useful, but shouldn't we provide an architecture helper function to do that
   since a semaphore structure _is_ an architecture-defined opaque structure.)
   
Feel free to make one.
