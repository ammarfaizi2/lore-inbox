Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287328AbSACPr4>; Thu, 3 Jan 2002 10:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSACPrm>; Thu, 3 Jan 2002 10:47:42 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:21030 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S287333AbSACPrR>;
	Thu, 3 Jan 2002 10:47:17 -0500
Message-ID: <3C347CC3.E7154C36@gmx.de>
Date: Thu, 03 Jan 2002 16:46:11 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu> <25193.1010018130@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
>
> What part of 'undefined behaviour' is so difficult for people to understand?

The behaviour is undefined by the C standard.  But the mentioned
pointer arithmetic is defined in the environment where it has been
used.  GCC tries to optimize undefined C-standard behaviour.  And
IMHO that's the point.  It may optimize defined behaviour and should
not touch things undefined by the standard.

Ciao, ET.

PS: Hey, we are talking about C, the de luxe assembler! *g*
