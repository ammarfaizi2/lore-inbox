Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbULLVRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbULLVRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbULLVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:16:51 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:56303 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262129AbULLVO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:14:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=N1a1IuR07PI+eNoSs2raZHf/ZZp1svg6yD6hlsQCYZy/jhZ6/ysy5emh8JIl1V/6frGy0n7IKGrTkiTQ7k7eDNAPEIfXGTmUF4k+4c1rKbPTIrzbt28hgKtFwyTKtFQHdsDofD2KsRSGKVOuNkcmXZEoRUsnyZiR/4hYON2XTMg=
Message-ID: <3fff1a7104121213141303e0bb@mail.gmail.com>
Date: Sun, 12 Dec 2004 23:14:55 +0200
From: Patrick <nawtyness@gmail.com>
Reply-To: Patrick <nawtyness@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Unknown Issue.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I've got a computer running gentoo, on a clean install where i've got
an odd problem :

after a while, the computer refuses to spawn processes anymore : 

-/bin/bash: /bin/ps: Input/output error
-/bin/bash: /usr/bin/w: Input/output error
-/bin/bash: /bin/df: Input/output error
-/bin/bash: /bin/mount: Input/output error

It happen's randomly, i've tried everything from changing the computer
from running software raid ( scsi ) to running a hardware solution and
reinstalling, I've run the memory through memtest as well as i've
remounted the drives and i've tested the ram to make sure it was
properly mounted.

The only thing running on this box is mysql, which runs perfectly at
7500 q/s ( running super smack ) now, i'm not sure if this is a linux
kernel thing, or a gentoo thing, or a hardware thing.

I've checked and i'm not running out of file descriptors ( by looking
in /proc/sys/fs/file-nr ) and i've increased the ammount in (
/proc/sys/fs/file-max ( if i member correctly ) ) by adding a 0 after
the end of the value thus increasing it alot.

It's running XFS on the root partition with a single partition, dual
xeon 2.66 with hyperthreading enabled, dual intel gbe and a adaptec
2120S AACraid card. Dual 36gb 10krpm scsi drives in raid1.

Does anyone have any ideas on what i can do, what i can test, if it's
hardware ? software ?

guys ? 

P

-- 
</N>

------
In the beginning, there was nothing. And God said, 'Let there be
Light.' And there was still nothing, but you could see a bit better.
