Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291429AbSBSOWn>; Tue, 19 Feb 2002 09:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291426AbSBSOWe>; Tue, 19 Feb 2002 09:22:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48514 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291425AbSBSOWV>; Tue, 19 Feb 2002 09:22:21 -0500
Date: Tue, 19 Feb 2002 09:24:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jens Schmidt <j.schmidt@paradise.net.nz>
cc: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
In-Reply-To: <3C724B02.CDF8F71F@paradise.net.nz>
Message-ID: <Pine.LNX.3.95.1020219092159.27270A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Jens Schmidt wrote:

> Hi All,
> 
> The information in this message is very interesting, and provided me with
> a real insight in the matter of magnetic media.
> 

You can't read back overwritten magnetic media by running some
magic program. However, it is not impossible to recover some
data from disk-drive tracks that have been overwritten. This
is because new data is unlikely to be written exactly over the
same area of a track as old data. This happens because of the
normal expansion and contraction of the media with changing
temperature.

By changing the alignment phase of the tracking servo, it
may be possible to read data that was written at a different
temperature. The data is not recovered intact, but a significant
percentage may be recovered, enough to be useful in a forensic
investigation or, perhaps espionage.

Since it is not impossible to recover such data, this information
is often exploited. I observed an advertisement on the Web which
showed a burned up disk-drive with its platters exposed and
charred. Implicit in the advertisement was that data had been
recovered from this drive. Such advertising is "legendary".

You can prevent recovery of overwritten data by keeping your
machine running all the while, thus at a near constant temperature.
If you periodically execute a program which writes a file large
enough to fill up the media, sync the file data, then delete it.
The result will be a drive clean enough so it would not contain
evidence of previous file-content except for file names. So,
if the file-name is not evidence you can be assured that the
"Thought Police" will not find your computer useful.

Truly paranoid persons should use file-names like this:

total 2916
drwxr-xr-x  53 root     root         4096 Feb 19 09:06 .
drwxr-xr-x  24 root     root         4096 Feb 19 05:03 ..
-rw-r--r--   1 root     root         1093 Oct 10 13:56 0x00000000 
-rw-r--r--   1 root     root          366 Aug  3  2001 0x00000001 
-rw-r--r--   1 root     root           69 Apr 24  1998 0x00000002 
-rw-r--r--   1 root     root          625 Jun  3  1998 0x00000003 
-rw-r--r--   1 root     root           43 Aug  4  1999 0x00000004 
-rw-r--r--   1 root     root          399 Feb 13 11:16 0x00000005 
-rw-r--r--   1 root     root           69 Aug  4  1999 0x00000006 
drwxr-xr-x   2 root     root         4096 Oct  9  2000 0x00000007 
drwxr-xr-x   2 root     root         4096 Aug 15  2000 0x00000008


Such file names contain no evidence of the file or directory
content. However, you note that there is some information conveyed
in the date-time. The date-time can be useful for evidence because
it (may) establish when the file was created or modified.

You can fix this problem by setting your system time to 1/1/1970
every time you boot. You could also install Windows-2000/Professional.
That Operating System doesn't stay running long enough to provide
useful evidence.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


