Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbSLEJ1d>; Thu, 5 Dec 2002 04:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSLEJ1d>; Thu, 5 Dec 2002 04:27:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21491 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267252AbSLEJ1c>;
	Thu, 5 Dec 2002 04:27:32 -0500
Message-ID: <3DEF1DB1.98CD4BB3@mvista.com>
Date: Thu, 05 Dec 2002 01:34:41 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: how is the asm-generic to be used?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lets say there is a bit of code in the kernel ( i.e.
.../kernel/ ) that needs a function that is in an
asm-gneric/*.h file.  Now someone comes along and does an
asm-x386/*.h with the same functionality but much faster asm
functions.  How should the using code be set up to get the
faster asm version if it exists and the generic version if
it does not?

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
