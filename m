Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274832AbRIUU7T>; Fri, 21 Sep 2001 16:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274833AbRIUU7K>; Fri, 21 Sep 2001 16:59:10 -0400
Received: from oe17.pav1.hotmail.com ([64.4.30.121]:5902 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S274832AbRIUU6q>;
	Fri, 21 Sep 2001 16:58:46 -0400
X-Originating-IP: [24.10.60.231]
From: "Dan Mann" <daniel_b_mann1@hotmail.com>
To: "Norbert Sendetzky" <norbert@linuxnetworks.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200109211609.SAA08383@post.webmailer.de>
Subject: Re: Implementing a new network based file system
Date: Fri, 21 Sep 2001 16:59:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE17XuqzOtYIoN92C0e0000d941@hotmail.com>
X-OriginalArrivalTime: 21 Sep 2001 20:59:05.0654 (UTC) FILETIME=[3FF9FD60:01C142E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, if you get this thing off the ground, write a windows and mac client
for it.  That would be really nice.

Dan
----- Original Message -----
From: "Norbert Sendetzky" <norbert@linuxnetworks.de>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, September 21, 2001 9:07 AM
Subject: Implementing a new network based file system


> Hi all
>
> I'm currently doing some research on implementiation of a new file
> system for my diplomathesis. It's about designing and implementing a
> network file system with security in mind. For those interested,
> there is a short introduction about why and how on my website (look
> at the Secure Internet File System section):
>
> http://www.linuxnetworks.de/security/index.html
>
> I have already studied ramfs sources for the basics and the sources
> of coda, nfs and smbfs to find out, what I have to do. Also I read
> all documentation I found about the VFS. But there are a few
> questions, where I couldn't find an answer:
>
>
> My first question is related to the superblock:
> There are six functions about inode handling. Each of the above
> network file systems (coda, nfs, smbfs) implements different
> functions:
>
> coda: read_inode and clear_inode
> nfs: read_inode, put_inode and delete_inode
> smbfs: put_inode and delete_inode
>
> When do I need which function? Why are they necessary at all when
> implementing a network file system? Can anyone explain the bigger
> scheme behind this to me?
>
>
> My second question is around inode_operations:
> Why does none of the network file systems implement the readlink,
> follow_link, truncate and getattr funtions? Does the server follow
> the symlink automatically if it is written to the storage medium and
> show only the resulting file?
>
>
> I have even more questions, but I will do some more research and
> maybe I will find the answer by myself before I get kicked off this
> list because of submitting too much obvious questions... (at least
> obvious to you) ;-)
>
> Thanks in advance
>
>
> Norbert
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
