Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbRGCIAj>; Tue, 3 Jul 2001 04:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266470AbRGCIA3>; Tue, 3 Jul 2001 04:00:29 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53414 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265592AbRGCIAM>;
	Tue, 3 Jul 2001 04:00:12 -0400
Message-ID: <3B417B89.6FE1D06A@mandrakesoft.com>
Date: Tue, 03 Jul 2001 04:00:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <3911.994146916@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> For example, one board I've got doesn't allow you to do a straight
> memory-mapped I/O access to your PCI device directly, but have to reposition a
> window in the CPU's memory space over part of the PCI memory space first, and
> then hold a spinlock whilst you do it.

Yuck.  Does that wind up making MMIO slower than PIO, on this board?

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
