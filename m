Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287619AbSAPVOw>; Wed, 16 Jan 2002 16:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287629AbSAPVNf>; Wed, 16 Jan 2002 16:13:35 -0500
Received: from adsl-64-164-18-186.dsl.snfc21.pacbell.net ([64.164.18.186]:43071
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S287619AbSAPVMl>; Wed, 16 Jan 2002 16:12:41 -0500
Message-ID: <3C45ECC2.6090208@switchmanagement.com>
Date: Wed, 16 Jan 2002 13:12:34 -0800
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: this is more interesting ...
In-Reply-To: <Pine.LNX.4.40.0201151752190.940-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>Booting my machine with vanilla 2.5.3-pre1 ( obsiously with corrected
>headers inclusion fix ) i've got and error from UMSDOS layer reporting a
>failing msdos_read_super() ( at boot ) and a panic about a failure to
>mount root. The interesting thing is that i do not have any msdos mounts,
>least of all root.
>
This might be the problem with msdos_read_super mistaking a reiserfs 
superblock for a FAT superblock, as discussed in a lkml thread starting 
Jan 13 14:38 -0800 with subject "Boot failure: msdos pushes in front of 
reiserfs" from Matthias Andree <matthias.andree@stud.uni-dortmund.de>.

Regards,
Brian

