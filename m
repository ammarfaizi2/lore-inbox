Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269057AbRHFWL1>; Mon, 6 Aug 2001 18:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269061AbRHFWLR>; Mon, 6 Aug 2001 18:11:17 -0400
Received: from zok.SGI.COM ([204.94.215.101]:64979 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S269057AbRHFWK7>;
	Mon, 6 Aug 2001 18:10:59 -0400
Date: Mon, 06 Aug 2001 15:07:59 -0700
From: richard offer <offer@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Red Phoenix <redph0enix@hotmail.com>
Subject: Re: Linux C2-Style Audit Capability
Message-ID: <1634130000.997135679@changeling.engr.sgi.com>
In-Reply-To: <fa.hg36o7v.1076epo@ifi.uio.no>
In-Reply-To: <fa.i3h9gdv.45k3go@ifi.uio.no> <fa.hg36o7v.1076epo@ifi.uio.no>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



* frm alan@lxorguk.ukuu.org.uk "08/04/01 09:24:11 +0000" | sed '1,$s/^/* /'
*
*> System calls are overridden by pointing sys_call_table[system call] to a 
*> replacement function which saves off the data for auditing purposes,
*> then  calls the original system call.
* 
* Ugly but that bit probably ties in with all the other folks trying to put
* together a unified security hook set for 2.5

Simply wrapping the system calls isn't going to get a CAPP (or C2)
compliant audit implementation. It also isn't how the "unified security
hooks" (aka LSM, Linux Security Modules) are working.

SGI is working towards a CAPP compliant audit implementation under the LSM
framework, I'd suggest that you head over to http://lsm.immunix.org/ for
more details on LSM.


richard.

-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________

