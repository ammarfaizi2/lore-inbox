Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131404AbQK0OXq>; Mon, 27 Nov 2000 09:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131489AbQK0OXg>; Mon, 27 Nov 2000 09:23:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25987 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S131404AbQK0OX0>; Mon, 27 Nov 2000 09:23:26 -0500
Date: Mon, 27 Nov 2000 08:53:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chad Schwartz <cwslist@main.cornernet.com>
cc: 64738 <schwung@rumms.uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel bits
In-Reply-To: <Pine.LNX.4.30.0011270734470.20724-100000@main.cornernet.com>
Message-ID: <Pine.LNX.3.95.1001127085204.20557B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Chad Schwartz wrote:

> int main(void) {
> 	printf("Size of an unsigned long is %d bytes\n",sizeof(unsigned long));
> 	return(0);
> }
> 
> That simple program will tell you that an unsigned long is 4 bytes, or 8
> bytes.
> 
> It is then a safe assumption - that if you get back '8', that you're
> running a 64bit kernel, on a 64bit processor.
> 
> Chad

I think sizeof(size_t) is more correct!


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
