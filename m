Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276060AbRJGD3W>; Sat, 6 Oct 2001 23:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276073AbRJGD3M>; Sat, 6 Oct 2001 23:29:12 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:49167 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276060AbRJGD27>;
	Sat, 6 Oct 2001 23:28:59 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11-pre vs Red Hat, ac kernels 
In-Reply-To: Your message of "Sat, 06 Oct 2001 09:21:32 MST."
             <3BBF2F8C.7F3D72E1@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Oct 2001 13:29:17 +1000
Message-ID: <21778.1002425357@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Oct 2001 09:21:32 -0700, 
J Sloan <jjs@pobox.com> wrote:
>With any 2.4.11-pre kernel so far, the machine locks
>up hard within seconds of starting a dbench run.
>No log entries, and SysRq keys have no effect -
>The power button is the only option in this case.

Does kdb + the NMI watchdog drop into the debugger and can you get a
backtrace?  ftp://oss.sgi.com/projects/kdb/download/ix86, boot with
"nmi_watchdog=1".

