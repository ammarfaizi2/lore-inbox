Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTAWPc4>; Thu, 23 Jan 2003 10:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTAWPc4>; Thu, 23 Jan 2003 10:32:56 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:56332 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265320AbTAWPcv>; Thu, 23 Jan 2003 10:32:51 -0500
Date: Thu, 23 Jan 2003 15:42:43 +0000 (GMT)
From: John@man.ac.uk
Subject: Re: [ACPI] ACPI patches updated (20030109)
To: andrew.grover@intel.com
cc: acpi-devel@sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A119@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E18bjUN-000FXY-00@probity.mcc.ac.uk>
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18bjUN-000FXY-00*ETwaOr9xAyc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan, Grover, Andrew wrote:
..
> ACPI patches based upon the 20030109 label have been released.

I have a Toshiba 3000-400 laptop, which previously needed a ACPI table
bypass for it to detect the battery power levels, which I have been
doing up to 2.4.17..  

I compiled up the standard 2.4.20 and my bypass hack didn't work
anymore..

I downloaded the 20030109 patch and tried it out with 2.4.20, but the
compilation failed  in 

	arch/i386/kernel/mpparse.c

I replaced the offending function by the one from the previous 20021212
patch and the 2.4.20 kernel compiled OK.

The patched 2.4.20 kernel now detects the laptop battery correctly along
with lots of other goodies that I'd not seen before..

Bye for now, and keep up the good work..

John


