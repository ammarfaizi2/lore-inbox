Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282238AbRKWUtY>; Fri, 23 Nov 2001 15:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282239AbRKWUtN>; Fri, 23 Nov 2001 15:49:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58072 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S282238AbRKWUtL>; Fri, 23 Nov 2001 15:49:11 -0500
Message-ID: <001a01c17460$4c0fc970$0100a8c0@dad>
From: "Norm Dressler" <ndressler@dinmar.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <002101c17430$d94b2f80$3828a8c0@ndrlaptop> <20011123.122538.74728853.davem@redhat.com>
Subject: Re: Sparc64 Compiles OK, but won't boot new kernel
Date: Fri, 23 Nov 2001 15:49:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was able to solve it -- I also had freeswan patched into the kernel and
when you include the debug portions, it more then doubles the size of your
kernel.

Norm

----- Original Message -----
From: "David S. Miller" <davem@redhat.com>
To: <ndressler@dinmar.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: November 23, 2001 3:25 PM
Subject: Re: Sparc64 Compiles OK, but won't boot new kernel


>
> Compile more things as modules, your kernel has too many things
> compiled statically into it and is therefore too large to boot.
>
>


