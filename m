Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRJLRdg>; Fri, 12 Oct 2001 13:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277799AbRJLRd0>; Fri, 12 Oct 2001 13:33:26 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:44535 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S277798AbRJLRdO>; Fri, 12 Oct 2001 13:33:14 -0400
Message-ID: <3BC729B0.577C352E@nortelnetworks.com>
Date: Fri, 12 Oct 2001 13:34:40 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: steveb@unix.lancs.ac.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel not booting when configured for Athlon
In-Reply-To: <200110121547.f9CFlXx11575@wing0.lancs.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steveb@unix.lancs.ac.uk wrote:
> 
> I've just replace my Pentium-III system with an Athlon-based one, I rebuilt
> the kernel with 'processor Family' changed from 'Pentium III' to Athlon/Duron/K7, and it failed to boot - it goes as far as "OK, booting the kernel" and hangs.
> 
> I can boot a kernel supposedly built for Pentium-III without any apparent problems.


Check the archives.  Apparently there is an issue with the highly optimized
Athlon specific memory access/clearing routines that leads to instability on
some motherboards/BIOS revisions.

There is a fix available that seems to clear this up, but it hasn't made it into
the mainstream kernel yet.

The only real difference between Athlon and PIII kernels are some
Athlon-specific optimized assembly-code.  The PIII versions still run, just not
quite as fast.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
