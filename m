Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313412AbSC2JLB>; Fri, 29 Mar 2002 04:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313414AbSC2JKx>; Fri, 29 Mar 2002 04:10:53 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:37133 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313412AbSC2JKm>;
	Fri, 29 Mar 2002 04:10:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Zed Pobre <zed@resonant.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: invalid operand 0000 (2.4.19-pre2, P2-266 SMP) 
In-Reply-To: Your message of "Fri, 29 Mar 2002 02:03:05 MDT."
             <20020329080305.GA16625@resonant.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Mar 2002 20:10:30 +1100
Message-ID: <29376.1017393030@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 02:03:05 -0600, 
Zed Pobre <zed@resonant.org> wrote:
>[5.] ksymoops was run on the same machine with no options set shortly
>     after the crash, but it still issued warnings.  I'm not sure why, or
>     if I need to do something different.
>
>ksymoops 2.4.3 on i686 2.4.19-pre2.  Options used
>     -V (default)
>     -k /proc/ksyms (default)
>     -l /proc/modules (default)
>     -o /lib/modules/2.4.19-pre2/ (default)
>     -m /boot/System.map-2.4.19-pre2 (default)
>
>Warning: You did not tell me where to find symbol information.  I will
>assume that the log matches the kernel and modules that are running
>right now and I'll use the default options above for symbol resolution.
>If the current kernel and/or modules do not match the log, you can get
>more accurate output by telling me the kernel version and where to find
>map, modules, ksyms etc.  ksymoops -h explains the options.

Standard warning that you are using the default values which may or may
not be sensible for your machine.

>Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base say=
>s c0239040, System.map says c015a890.  Ignoring ksyms_base entry

Kernel has two symbols called partition_name.  Corrected in 2.4.19-pre4.

