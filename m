Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbRGBSWu>; Mon, 2 Jul 2001 14:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbRGBSWk>; Mon, 2 Jul 2001 14:22:40 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:33441 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S265385AbRGBSW3>; Mon, 2 Jul 2001 14:22:29 -0400
Date: Mon, 2 Jul 2001 19:22:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
        Jes Sorensen <jes@sunsite.dk>, linux-kernel@vger.kernel.org,
        arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions
Message-ID: <20010702192227.B29246@flint.arm.linux.org.uk>
In-Reply-To: <19921.994092096@redhat.com> <E15H70K-0006Cn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15H70K-0006Cn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 02, 2001 at 05:56:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 05:56:56PM +0100, Alan Cox wrote:
> Case 1:
> 	You pass a single cookie to the readb code
> 	Odd platforms decode it

Last time I checked, ioremap didn't work for inb() and outb().

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

