Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbSA1XCv>; Mon, 28 Jan 2002 18:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSA1XCk>; Mon, 28 Jan 2002 18:02:40 -0500
Received: from alpha9.cc.monash.edu.au ([130.194.1.9]:20487 "EHLO
	ALPHA9.CC.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S287333AbSA1XC3>; Mon, 28 Jan 2002 18:02:29 -0500
Date: Tue, 29 Jan 2002 10:01:32 +1100
From: Kim Oldfield <swsusp@oldfield.wattle.id.au>
Subject: Re: [swsusp] swsusp for 2.4.17 -- newer ide supported
In-Reply-To: <20020128100704.GA3013@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Swsusp mailing list <swsusp@lister.fornax.hu>
Message-id: <20020128230132.GB24550@barclay.its.monash.edu.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
Content-transfer-encoding: 7BIT
User-Agent: Mutt/1.3.25i
In-Reply-To: <20020128100704.GA3013@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2002, Pavel Machek typed:
] This is newer version of swsusp patch. It now supports newer ide
] driver (which just about everybody uses). It sometimes fails to
] suspend when top is running, otherwise no bugs are known. Try to break
] this one!

(As with previous versions) it does not work with ext3:

Cut and paste from syslog:
twilight kernel: SysRq : Software suspend
twilight kernel: 
twilight kernel: Suspend Machine: Stopping processes
twilight kernel: Suspend Machine: Waiting for tasks to stop... ::::::::::::::::::::::::::::
twilight kernel:  stopping tasks failed (1 tasks remaining)
twilight kernel: Suspend Machine: Not all processes stopped!
twilight kernel: Resume Machine: Restarting tasks...<6> Strange, kjournald not stopped
twilight kernel:  done
twilight kernel: Resume Machine: Done resume from 0

Regards,
Kim
