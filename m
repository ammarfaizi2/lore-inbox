Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131188AbQK0Nz3>; Mon, 27 Nov 2000 08:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131258AbQK0NzT>; Mon, 27 Nov 2000 08:55:19 -0500
Received: from main.cornernet.com ([209.98.65.1]:64272 "EHLO
        main.cornernet.com") by vger.kernel.org with ESMTP
        id <S131188AbQK0NzH>; Mon, 27 Nov 2000 08:55:07 -0500
Date: Mon, 27 Nov 2000 07:36:22 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: 64738 <schwung@rumms.uni-mannheim.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bits
In-Reply-To: <974881541.3a1b830585e86@rumms.uni-mannheim.de>
Message-ID: <Pine.LNX.4.30.0011270734470.20724-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

int main(void) {
	printf("Size of an unsigned long is %d bytes\n",sizeof(unsigned long));
	return(0);
}

That simple program will tell you that an unsigned long is 4 bytes, or 8
bytes.

It is then a safe assumption - that if you get back '8', that you're
running a 64bit kernel, on a 64bit processor.

Chad


On Wed, 22 Nov 2000, 64738 wrote:

> Hi.
>
> Is there a syscall or something that can tell me whether I'm working on a 32-
> or a 64-bit kernel?
>
> Greeting,
>  Alain
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
