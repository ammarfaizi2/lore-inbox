Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129204AbQKBTVh>; Thu, 2 Nov 2000 14:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129378AbQKBTV1>; Thu, 2 Nov 2000 14:21:27 -0500
Received: from web9904.mail.yahoo.com ([216.136.129.247]:20744 "HELO
	web9904.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129204AbQKBTVP>; Thu, 2 Nov 2000 14:21:15 -0500
Message-ID: <20001102192108.85567.qmail@web9904.mail.yahoo.com>
Date: Thu, 2 Nov 2000 11:21:08 -0800 (PST)
From: Ivo Zivkov <izivkov@yahoo.com>
Subject: Floating point emulation problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-705367418-973192868=:83031"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-705367418-973192868=:83031
Content-Type: text/plain; charset=us-ascii


Dear List,

I am running kernel 2.2.5-15. I am trying to calculate sin(0.9), and it crashes on a 386 board with no f/p hardware. The message I get is:

"Unable to handle kernel paging request at virtual address 7f3c0070......"

The interesting thing is sin(0.8) works fine. On a Pentium the program executes fine for all values.

I tried in 2 different 386 boards, and I get the same problem. The program was compiled on R.H.6.0, and "libm" was present on the 386. I even linked the program statically to eliminate any library dependencies. 

This seems like a common problem, and easy to reproduce. Anybody had the same experience?

please reply to mailto:izivkov@yahoo.com

Regards,

Ivo

 



---------------------------------
Do You Yahoo!?
>From homework help to love advice, Yahoo! Experts has your answer.
--0-705367418-973192868=:83031
Content-Type: text/html; charset=us-ascii

<FONT size=2>
<P>Dear List,</P>
<P>I am running kernel 2.2.5-15. I am trying to calculate sin(0.9), and it crashes on a 386 board with no f/p hardware. The message I get is:</P>
<P>"Unable to handle kernel paging request at virtual address 7f3c0070......"</P>
<P>The interesting thing is sin(0.8) works fine. On a Pentium the program executes fine for all values.</P>
<P>I tried in 2 different 386 boards, and I get the same problem. The program was compiled on R.H.6.0, and "libm" was present on the 386. I even linked the program statically to eliminate any library dependencies. </P>
<P>This seems like a common problem, and easy to reproduce. Anybody had the same experience?</P>
<P>please reply to <A href="mailto:izivkov@yahoo.com">mailto:izivkov@yahoo.com</A></P>
<P>Regards,</P>
<P>Ivo</P>
<P>&nbsp;</P></FONT><p><br><hr size=1><b>Do You Yahoo!?</b><br>
>From homework help to love advice, <a href="http://experts.yahoo.com/">Yahoo! Experts</a> has your answer.
--0-705367418-973192868=:83031--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
