Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSENS3I>; Tue, 14 May 2002 14:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315972AbSENS3H>; Tue, 14 May 2002 14:29:07 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:44074 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S315971AbSENS3F>;
	Tue, 14 May 2002 14:29:05 -0400
Date: Tue, 14 May 2002 19:29:08 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: William Stearns <wstearns@pobox.com>
cc: Dead2 <dead2@circlestorm.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Initrd or Cdrom as root
In-Reply-To: <Pine.LNX.4.44.0205141357410.2626-100000@sparrow.websense.net>
Message-ID: <Pine.LNX.4.33.0205141920420.1577-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, William Stearns wrote:

> Good day, Mr. Expired,
>
> On Tue, 14 May 2002, Dead2 wrote:
>
> > Unfortunately it boots too fast for me to see that message..
>
> dmesg | less
> less /var/log/dmesg
> 	Some distributions save the boot time dmesg output here.
> 	Cheers,
> 	- Bill

And how exactly do you suggest to type that command if the kernel panics?
If he had kdb he could do "mds saved_command_line 100".

I suspect that whatever is he using for creating the images (what is this
"isolinux.cfg"?) has modified the boot command line and that is why it
fails. It works fine for me (and worked since the time I wrote it around
2.4.0 or so).

Regards
Tigran

