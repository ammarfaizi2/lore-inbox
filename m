Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263905AbRFDVwC>; Mon, 4 Jun 2001 17:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRFDVvx>; Mon, 4 Jun 2001 17:51:53 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:12951 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S263905AbRFDVvk>; Mon, 4 Jun 2001 17:51:40 -0400
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: "YU,SAMMY (HP-Roseville,ex1)" <sammy_yu@hp.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <80256A61.007805C0.00@d06mta06.portsmouth.uk.ibm.com>
Date: Mon, 4 Jun 2001 22:50:26 +0100
Subject: Re: I/O tracing
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You can use either dprobes to set up a tracepoint dynamically anywhere you
please see:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

Or, you can use gkhi to define a hook anywhere in the kernel you please.
You can write a hook exit as a kmod to do whatever you fancy and have it
activate at a tome of your choosing. See,
http://oss.software.ibm.com/developerworks/opensource/linux/projects/gkhi

Or, you can investigate some of the standard tracepoint Linux Trace Toolkit
creates, see: http://www.opersys.com/

And that's only three of many....


Richard Moore -  RAS Project Lead - Linux Technology Centre (ATS-PIC).
http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


"YU,SAMMY (HP-Roseville,ex1)" <sammy_yu@hp.com> on 04/06/2001 19:37:23

Please respond to "YU,SAMMY (HP-Roseville,ex1)" <sammy_yu@hp.com>

To:   linux-kernel@vger.kernel.org
cc:
Subject:  I/O tracing




Hi,
     Please CC me as I'm not subscribed on the list, thanks.  Not sure if
this is appropriate forum, is there an existing tool/module for capturing
all the I/O requests such as:

Unique Identifier
Start Time
End Time
Device Identifier
Operation Type (Read Or Write)
Offset
Length (Number Of Bytes)

I am aware of existing /proc/disks and partitions, but these aren't real
time.  If not, are there any facilities in the kernel I can put a hook in
to
keep track of the I/O?


Thanks in advance,
Sammy Yu
Hewlett-Packard

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



