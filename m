Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTKLKbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 05:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTKLKbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 05:31:05 -0500
Received: from ACaen-202-1-7-4.w81-248.abo.wanadoo.fr ([81.248.160.4]:13096
	"HELO Genesyme.localdomain") by vger.kernel.org with SMTP
	id S261875AbTKLKbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 05:31:03 -0500
Subject: Re: reiserfs 3.6 problem with test9
From: Philippe <rouquier.p@wanadoo.fr>
To: bill davidsen <davidsen@tmr.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031111135948.GA5229@linalco.com>
References: <1068553197.1018.43.camel@Genesyme>
	 <20031111135948.GA5229@linalco.com>
Content-Type: text/plain
Message-Id: <1068633363.1197.19.camel@Genesyme>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 12 Nov 2003 11:36:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just as a data point, have you tried simply unmounting and remounting
> the f/s? 

Mounting and unmounting is done every time I boot my computer, that is every
day. I haven't seen any error message so far with fsck. 
Maybe I haven't understood what you meant.

If the fsck found anything wrong then I didn't say that, but if
> there were no reported errors in the actual f/s then it is possible that
> the metadata in memory is being corrupted. 

The errors I mentionned are the same every time on the same files.
I get them whenever I check for corrupted files with find / -name klqsjdfhkjlsdfh.
Of course I don't have any file with this name but find write on stdout all files 
it could not access in the system.

which metadata are you talking about? The one in memory or those on the disk?
I check the memory with memtest (no problem) and the disk with badblocks (no problem)
and rebuilt the SB and the FS so there shouldn't be any problem with metadata.

Sorry if I sound stupid but I don't know anything about all that. I'm at loss about what
to do and even think about switchin between reiserfs and ext3.

regards


