Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131755AbQKZPC7>; Sun, 26 Nov 2000 10:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131870AbQKZPCu>; Sun, 26 Nov 2000 10:02:50 -0500
Received: from 4dyn13.com21.casema.net ([212.64.95.13]:2067 "HELO home.ds9a.nl")
        by vger.kernel.org with SMTP id <S131755AbQKZPCd>;
        Sun, 26 Nov 2000 10:02:33 -0500
Date: Sun, 26 Nov 2000 15:32:23 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126153222.A26728@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3a219890.57346310@mail.mbay.net> <Pine.LNX.4.21.0011261048130.1039-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.21.0011261048130.1039-100000@penguin.homenet>; from tigran@veritas.com on Sun, Nov 26, 2000 at 10:52:05AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 10:52:05AM +0000, Tigran Aivazian wrote:

> that _you_ my dear friend, do not know where the BSS clearing code is. It
> is not in setup.S. It is not even in the same directory, where setup.S is.
> It is in arch/i386/kernel/head.S, starting from line 120:

On a related note, I seem to remember that back in the dark ages, the BSS
wasn't cleared. It said so somewhere in the Kernel Hackers Guide, I think.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
