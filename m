Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbRBMIlD>; Tue, 13 Feb 2001 03:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbRBMIkx>; Tue, 13 Feb 2001 03:40:53 -0500
Received: from mx2.nameplanet.com ([213.203.30.52]:57099 "HELO
	mx2.nameplanet.com") by vger.kernel.org with SMTP
	id <S130417AbRBMIki>; Tue, 13 Feb 2001 03:40:38 -0500
Date: 13 Feb 2001 08:40:31 -0000
Message-ID: <20010213084031.8598.qmail@www1.nameplanet.com>
From: ketil@froyn.com
To: mas9483@ksu.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: gzipped executables
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001 23:09:39 -0600 (CST) Matt Stegman <mas9483@ksu.edu> wrote:
>Is there any kernel patch that would allow Linux to properly recognize,
>and execute gzipped executables?
>
>I know I could use binfmt_misc to run a wrapper script:
>
>    decompress to /tmp/prog.decompressed
>    execute /tmp/prog.decompressed
>    rm /tmp/prog.decompressed
>
>But that's not as clean, secure, or fast as the kernel transparently
>decompressing & executing.  Is there a better way to do this?

Perhaps you could put it in the filesystem. Look at the "chattr" manpage, which
shows how this is meant to work with ext2. It seems not to have been implemented
yet. This way you could also compress any files, not just executables.

Ketil

-- 
Get your firstname@lastname email for FREE at http://Nameplanet.com/?su
