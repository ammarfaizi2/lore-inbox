Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129097AbQKWSmE>; Thu, 23 Nov 2000 13:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129091AbQKWSl4>; Thu, 23 Nov 2000 13:41:56 -0500
Received: from 60-VALL-X12.libre.retevision.es ([62.83.208.188]:1664 "EHLO
        looping.es") by vger.kernel.org with ESMTP id <S129097AbQKWSlm>;
        Thu, 23 Nov 2000 13:41:42 -0500
Date: Thu, 23 Nov 2000 19:20:34 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ragnar Hojland Espinosa <ragnar@jazzfree.com>, Andries.Brouwer@cwi.nl,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
Message-ID: <20001123192034.A155@macula.net>
In-Reply-To: <20001123175849.A116@macula.net> <Pine.LNX.4.10.10011230911200.7992-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <Pine.LNX.4.10.10011230911200.7992-100000@penguin.transmeta.com>; from Linus Torvalds on Thu, Nov 23, 2000 at 09:20:15AM -0800
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 09:20:15AM -0800, Linus Torvalds wrote:
> Can you check whether the single patch of _just_ removing the extra "f_pos
> >= i_size" test in do_isofs_readdir() fixes it? The other changes of
> Andries patch look like they should not affect code generation at all, but
> I'd still like to verify that it's only that part. If so, it definitely

Verified, it does.

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
