Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286907AbRL1Nfa>; Fri, 28 Dec 2001 08:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286908AbRL1NfV>; Fri, 28 Dec 2001 08:35:21 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:9489 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286907AbRL1NfL>; Fri, 28 Dec 2001 08:35:11 -0500
Date: Fri, 28 Dec 2001 14:35:08 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
Message-ID: <20011228133508.GA12303@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Roy Hills wrote:

> Note that I build the kernels on a separate machine, hence the "scp" to
> copy the kernel & sysmap to the target system.
> 
> The old 2.2.17 zImage kernel that runs fine has a filesize of 462060 bytes 
> and
> reports 784k kernel code, 412k reserved, 1168k data, 36k init.
> 
> The new 2.2.20 zImage kernel that fails has a filesize of 482795 bytes.
> Actual sizes are not known as the system fails with "out of memory" just
> after the decompression of the kernel and before any kernel messages get 
> printed.

Hum, I recall this struck another 2.2.x version already, and the
workaround was to hack some HASH size in one of the arch/i386/boot/
files. I don't recall the details, but you can find them in the
archives.
