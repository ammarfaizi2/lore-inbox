Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272576AbRJCKbm>; Wed, 3 Oct 2001 06:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272592AbRJCKbc>; Wed, 3 Oct 2001 06:31:32 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:36294 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272576AbRJCKbT>; Wed, 3 Oct 2001 06:31:19 -0400
Date: 03 Oct 2001 10:33:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8A89yinmw-B@khms.westfalen.de>
In-Reply-To: <20011003050142.AAA10921@shell.webmaster.com@whenever>
Subject: Re: Getting system time in kernel..
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3458.1002015803@redhat.com> <20011003050142.AAA10921@shell.webmaster.com@whenever>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davids@webmaster.com (David Schwartz)  wrote on 02.10.01 in <20011003050142.AAA10921@shell.webmaster.com@whenever>:

> On Tue, 02 Oct 2001 10:43:23 +0100, David Woodhouse wrote:
>
> >mohammedazad@nestec.net said:
>
> >> Any idea how to get the system time in a kernel module.... I tried  this
> >>in solaris... but i am getting only the GMT (that too elapsed  time) how
> >>do i convert this to my locale time....
>
> >You can't. You shouldn't need to convert to localtime inside the kernel.
> >What, precisely, are you trying to achieve?
>
> 	As an example, a filesystem might internally store local times in its
> inodes. You may not be free to change the on-disk format.

Such as FAT and derived filesystems?

That's why Linux has sys_tz. Though I think that a mount option to  
override that might have been wise.

MfG Kai
