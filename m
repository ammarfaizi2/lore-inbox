Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293335AbSCEPZQ>; Tue, 5 Mar 2002 10:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293342AbSCEPZG>; Tue, 5 Mar 2002 10:25:06 -0500
Received: from h00403399c977.ne.mediaone.net ([24.218.248.214]:21712 "EHLO
	fred.cambridge.ma.us") by vger.kernel.org with ESMTP
	id <S293335AbSCEPYx>; Tue, 5 Mar 2002 10:24:53 -0500
From: pjd@fred001.dynip.com
Message-Id: <200203051523.g25FN2j02633@fred.cambridge.ma.us>
Subject: Re: Need Suggestion(modifying kernel source)
To: cvaka_kernel@yahoo.com (chiranjeevi vaka)
Date: Tue, 5 Mar 2002 10:23:01 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020304212315.89890.qmail@web21305.mail.yahoo.com> from "chiranjeevi vaka" at Mar 04, 2002 01:23:15 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chiranjeevi vaka wrote:
> 
> The major problem I am getting is, as and when I do a
> small change, to test that change, I have to compile
> the whole kernel make boot floppy and reboot the
> kernel with that floppy and test the code. This way is
> takinbg too much time. I donno how linux kernel
> developers will make changes to kernel and test them. 

A possibility that no one has mentioned is to have a diskless
target machine, booting with TFTP and using an NFS root filesystem.
Boot NILO (www.nilo.org) on a floppy, and configure it to load
the kernel off a TFTP server, which would also be the machine you
compile and run kgdb on.

One advantage is that no matter how badly you crash the target
machine you won't corrupt the filesystem.

............................................................................
 Peter Desnoyers 
 162 Pleasant St.         (617) 661-1979          pjd@fred.cambridge.ma.us
 Cambridge, Mass. 02139

