Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133070AbRDLMZW>; Thu, 12 Apr 2001 08:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133111AbRDLMZN>; Thu, 12 Apr 2001 08:25:13 -0400
Received: from [209.101.91.34] ([209.101.91.34]:1285 "EHLO mail.compro.net")
	by vger.kernel.org with ESMTP id <S133070AbRDLMZK>;
	Thu, 12 Apr 2001 08:25:10 -0400
Message-ID: <3AD59EB9.35F3A535@compro.net>
Date: Thu, 12 Apr 2001 08:25:29 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: markh@compro.net
Subject: amiga affs support broken in 2.4.x kernels??
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm not a list member so IF you respond to this mail please CC me.
I've been looking at the archives and see some problems with the 2.3.x
kernel versions and affs support. I havn't tried any 2.3.x versions but
starting with 2.4.0 I can no longer mount an affs file system. No matter
if loopback or an actual device. 2.2.x kernels work greate. Does anyone
KNOW whether this still works or not and if not maybe a patch somwhere
for the 2.4.x kernels. It doesn't appear that anything has changed in
the
/usr/src/linux/fs/affs dircetory since at least 2.2.14 so I beleive the
problem to be else where. I've tried all the versions of util-linux and
all work with 2.2.14/2.2.18. What happens whin I try to mount an affs
fs using the command "mount -t affs /dev/sdc1 /mnt" is the mount command
just hangs and CANNOT be killed. If I access any files on the system
after
the hang I get major file corruption. If I imediatly hit the kill switch
then it is usually recoverable. Any response/help would be greatly
appc'd

Regards
Mark Hounschell
markh@compro.net
