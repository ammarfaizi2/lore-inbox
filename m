Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274193AbRISVQP>; Wed, 19 Sep 2001 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274194AbRISVQF>; Wed, 19 Sep 2001 17:16:05 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:38150 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274193AbRISVP5>; Wed, 19 Sep 2001 17:15:57 -0400
X-Apparently-From: <swansma@yahoo.com>
Message-ID: <3BA8F6EC.E3D73C87@yahoo.com>
Date: Wed, 19 Sep 2001 15:50:04 -0400
From: Mark Swanson <swansma@yahoo.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.8-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Request: removal of fs/fs.h/super_block.u to enable partition 
 locking
In-Reply-To: <E15jn1X-0003cU-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> You are not going to stop a tired sysadmin doing something daft. You can
> certainly create a GPL'd raw partition as a file fs (I believe someone did
> that so INN could mmap raw on a device)
> 
> However you don't need to remove anything for that

But I can't distribute the file fs with my application,
because I can't expect my
user base to patch and recompile their kernel just so they can run
my application.

Perhaps what is needed is an 'inuse' filesystem or a way to make 
filesystem modules without patching the kernel. 

My concern is that ordinary tools like mount check the proc filesystem
to see if a partition is already mounted and it seems likely that tools
like mke2fs do this too. Sysadmins might feel that existing tools
protect
them from damaging something in use. I'm looking for a way to follow
this
general behavior with raw partitions.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

