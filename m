Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263909AbRFNSsH>; Thu, 14 Jun 2001 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRFNSr5>; Thu, 14 Jun 2001 14:47:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43186 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263925AbRFNSrm>;
	Thu, 14 Jun 2001 14:47:42 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.1739.395626.842663@pizda.ninka.net>
Date: Thu, 14 Jun 2001 11:47:39 -0700 (PDT)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), tom_gall@vnet.ibm.com (Tom Gall),
        linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <200106141801.f5EI13s413231@saturn.cs.uml.edu>
In-Reply-To: <15144.51504.8399.395200@pizda.ninka.net>
	<200106141801.f5EI13s413231@saturn.cs.uml.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Albert D. Cahalan writes:
 >    You've added an ioctl. This isn't just any ioctl. It's a
 >    wicked nasty ioctl. It's an OH MY GOD YOU CAN'T BE SERIOUS
 >    ioctl by any standard.

It's an ioctl which allows things to work properly in the framework we
currently have.

 >    Fix:
 > 
 >    /proc/bus/PCI/0/0/3/0/config   config space

Which breaks xfree86 instantly.  This fix is unacceptable.

In fact, the current ioctl/mmap machanism was discussed with and
agreed to by the PPC, Alpha, and Sparc64 folks.

Later,
David S. Miller
davem@redhat.com
