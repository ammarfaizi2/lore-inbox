Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQJaOee>; Tue, 31 Oct 2000 09:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbQJaOeY>; Tue, 31 Oct 2000 09:34:24 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:45061 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129097AbQJaOeR>;
	Tue, 31 Oct 2000 09:34:17 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Petko Manolov <petkan@dce.bg>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: changed section attributes 
In-Reply-To: Your message of "Tue, 31 Oct 2000 16:29:16 +0200."
             <39FED73C.A4BA630D@dce.bg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2000 01:34:11 +1100
Message-ID: <17144.973002851@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 16:29:16 +0200, 
Petko Manolov <petkan@dce.bg> wrote:
>I wonder why the compiler decides to add ".section
>.modinfo,"a",@progbits"
>May be this is the thing which should be fixed.

That is just gcc speak for section .modinfo is marked as allocated,
type progbits.  Read the ELF standard if you want to know more.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
