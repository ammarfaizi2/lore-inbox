Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLHJAx>; Fri, 8 Dec 2000 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129545AbQLHJAn>; Fri, 8 Dec 2000 04:00:43 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:47355 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S129477AbQLHJAh>; Fri, 8 Dec 2000 04:00:37 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: linux-kernel@vger.kernel.org
Message-ID: <802569AF.002EAD36.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 8 Dec 2000 08:29:01 +0000
Subject: Re: who is writing to disk
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



One option, if there's no bespoke mechanism is to use DPorbes and or Linux
Trace Toolkit to set up a trace of file system apis. You could also start
with strace.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Zhiruo Cao <zhiruo@cc.gatech.edu> on 08/12/2000 02:25:03

Please respond to Zhiruo Cao <zhiruo@cc.gatech.edu>

To:   linux-kernel@vger.kernel.org
cc:   zhiruo@cc.gatech.edu
Subject:  who is writing to disk





Hello,

I found a process constantly writing to disk when I run gnome as desktop
and while the whole system is idle.  I don't find anything in the log
file, and I don't see anything updated in my home dir or in /tmp.  Does it
sound like bdflush is writing?  But I don't hear the disk access when I
am not running gnome.

My question then is, is there a (monitoring) tool that can tell me who is
writing to disk?  Or how I configure the kernel to know that?

Thanks!

Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
