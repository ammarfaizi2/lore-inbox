Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286266AbRLTPHK>; Thu, 20 Dec 2001 10:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286272AbRLTPHA>; Thu, 20 Dec 2001 10:07:00 -0500
Received: from bacon.van.m-l.org ([208.223.154.200]:14979 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S286266AbRLTPGy>; Thu, 20 Dec 2001 10:06:54 -0500
Date: Thu, 20 Dec 2001 10:06:42 -0500 (EST)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal 
In-Reply-To: <3794.1008858687@redhat.com>
Message-ID: <Pine.LNX.4.33.0112201001510.23808-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, David Woodhouse wrote:

>jakob@unthought.net said:
>>  Take a look at Win32, they have it.
>
>Which is partly why when you want to copy a large file on an SMB-exported
>file system, the client host doesn't have to actually read it all and write 
>it back across the network - it can just issue a copyfile request.

What does a copy system call have to do with the file server program being
smart enough to do a copy locally?  You can't do it with FTP (or at least
the ftpd I have) but it's certainly not because read()+write() are
insufficient.

-George Greer

