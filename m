Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129848AbQJaXlz>; Tue, 31 Oct 2000 18:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129923AbQJaXlp>; Tue, 31 Oct 2000 18:41:45 -0500
Received: from ppp-97-143-an04u-dada6.iunet.it ([151.35.97.143]:10761 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S129848AbQJaXlm>;
	Tue, 31 Oct 2000 18:41:42 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Date: Wed, 1 Nov 2000 01:56:17 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011010122160.18143-100000@elte.hu> <39FF5332.7C862223@timpanogas.org>
In-Reply-To: <39FF5332.7C862223@timpanogas.org>
MIME-Version: 1.0
Message-Id: <00110101575902.02672@linux1.home.bogus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2000, Jeff V. Merkey wrote:
> 
> mov    eax, addr
> mov    [addr], ebx
> 

Probably You mean this :

mov	r/imm, %eax
mov	(%eax), %ebx


- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
