Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290938AbSASLb2>; Sat, 19 Jan 2002 06:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290939AbSASLbS>; Sat, 19 Jan 2002 06:31:18 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:21974 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290938AbSASLbI>; Sat, 19 Jan 2002 06:31:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [question] implentation of smb-browsing: kernel space or user space?
Date: Sat, 19 Jan 2002 12:30:28 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16RtOX-0007Ao-00@mrvdom00.kundenserver.de>
In-Reply-To: <E16RtOX-0007Ao-00@mrvdom00.kundenserver.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16Rthx-1WF6ESC@fwd00.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Therefore I had the idea, to implement this smb-browsing feature in kernel
> space. It will be a kind of network neighbourhood-filesytem with all
> computers as top level directories below the mount point.

What could a kernel space browser do that a demon could not do ?

> The first step might be to glue the autofs with smbfs and add a kernel smb
> browser as a proof of concept.

Do you say that autofs cannot be used to mount smbfs shares ?

> My question is: Do you think, that this kind of filesystem is sensible, or
> do you think that smb-stuff has to be in user space. (for example using the
> filesystem in userspace approach, shown some weeks ago)?

Smbfs itself must be in kernel. That doesn't imply that the browser has to
be in kernel.

	Regards
		Oliver
