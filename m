Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbREHMyw>; Tue, 8 May 2001 08:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbREHMyn>; Tue, 8 May 2001 08:54:43 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:34790 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132482AbREHMye>; Tue, 8 May 2001 08:54:34 -0400
Date: Tue, 8 May 2001 07:54:30 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105081254.HAA27582@tomcat.admin.navo.hpc.mil>
To: joelbeach@optushome.com.au, linux-kernel@vger.kernel.org
Subject: Re: ide messages in log. Hard disk dying or linux ide problem?
In-Reply-To: <20010508075901.MQOW13554.mss.rdc2.nsw.optushome.com.au@kinslayer>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joel Beach" <joelbeach@optushome.com.au>:
> Hi,
> 
> Until three or four weeks ago, I have been running kernel 2.4.2 with no
> problems. However, my hard disk now seems to be playing up. In my system log, I
> get the following messages.
> 
> May  3 08:13:14 kinslayer kernel: hda: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=3790389, sector=3790208
> May  3 08:13:14 kinslayer kernel: end_request: I/O error, dev 03:01 (hda),
> sector 3790208
> May  3 08:22:34 kinslayer kernel: hda: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=4614116, sector=4613824
> May  3 08:22:34 kinslayer kernel: end_request: I/O error, dev 03:01 (hda),
> sector 4613824
> 
> This only seems to affect access to my mounted FAT32 partition. Sometimes,
> windows itself won't load because it can't find the registry file. 
> 
> The problem manifests itself when the computer is first turned on. You can tell
> immediately if the problem is going to happen as the BIOS autodetect of the
> hard drive takes a long time. The access noise is also quite peculiar, with
> three low pitched accesses, followed by three high pitched accesses.
> 
> The problem seems to disappear after the computer has been used for a while,
> which seems to suggest flakey hardware to me.

Flakey hardware... It is amazing, but I just had an IDE disk fail (continuous
running for the last year and a half - disk, not system) with the same
symptoms. We decided that it was a head crash. Sometimes the disk was
identified, sometimes not. After the initial failure it ran for about 12 hours,
then did it again. Off and on it would work, sometimes recognized, sometimes
unable to read the partition table. I got it working just long enough to copy
most of the current configuration files.

A windows diagnostic disk couldn't even recover the disk via low level
formatting (we didn't expect it to, but wanted to try the software out).

In addition to the errors you show, it is possbile to also get "short read"
errors too.

BTW - the kernel was an old 2.0.33 system that has given very good service...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
