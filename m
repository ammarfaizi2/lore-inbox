Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279196AbRJ2MDX>; Mon, 29 Oct 2001 07:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279241AbRJ2MDN>; Mon, 29 Oct 2001 07:03:13 -0500
Received: from 146.241.88.213.host.songnetworks.se ([213.88.241.146]:17167
	"EHLO dican.se") by vger.kernel.org with ESMTP id <S279196AbRJ2MDB>;
	Mon, 29 Oct 2001 07:03:01 -0500
Message-ID: <3BDD4593.74988F93@dican.se>
Date: Mon, 29 Oct 2001 13:03:31 +0100
From: Magnus Sundberg <Magnus.Sundberg@dican.se>
Organization: Dican AB
X-Mailer: Mozilla 4.71 [en] (WinNT; I)
X-Accept-Language: sv,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Does VFS cache individual files? Is the linker involved?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sirs,

QUESTION:
Does VFS cache the content of a file?

Does VFS consult memory instead of disk, when accessing a file that is
already linked to a process that is running?


RELATED INFORMATION:
Operating system RedHat 7.1, kernel 2.4.3-12 (from RedHat RPM)
My webserver runs tripwire for integrity test of critical files.

One night, when the PHP runtime of apache had crashed, tripwire reported
checksum error of
/usr/lib/apache/libphp4.so
The next night, when apache was restarted, there where no checksum
errors of the file.

I have seen checksum errors of /lib/libc-2.2.2.so, rpm also reported md5
checksum error when I
used rpm to verify the installation of glibc.

Thank you for your time reading this

regards,

Magnus Sundberg


