Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbRH1UBV>; Tue, 28 Aug 2001 16:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRH1UBL>; Tue, 28 Aug 2001 16:01:11 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:45213 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S268511AbRH1UA5>; Tue, 28 Aug 2001 16:00:57 -0400
Date: Tue, 28 Aug 2001 13:01:22 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: 2.4.9ac3 fails to boot (due to agpgart)...
Message-ID: <Pine.LNX.4.33.0108281052590.29611-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an rcc/serverworks IIIHE-sl box (dual pIII-1ghz) with root on a
aic7xxx controller integrated on the mainboard...

as soon a the kernel gets to initializing the agpgart. the message:

"posted write buffer flush took more than three seconds"

begins scrolling down the screen...

the last line before it happens is:

"maximum memory available for agp is 816MB"

which seems like a reasonable number (the machine has 1GB)

alt-sysrq b will still reboot the machine at that point...

disabling agpgart support eliminaates the issue...

joelja



-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.




