Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUBROIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUBROIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:08:37 -0500
Received: from sea2-dav57.sea2.hotmail.com ([207.68.164.192]:31754 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S267361AbUBROIe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:08:34 -0500
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Nikita Danilov" <Nikita@Namesys.COM>
Cc: <linux-kernel@vger.kernel.org>,
       "Reiserfs mail-list" <Reiserfs-List@Namesys.COM>
References: <Sea2-DAV22IBirXXeQM0000aeb5@hotmail.com> <16435.27477.679757.404161@laputa.namesys.com>
Subject: Re: ReiserFS corruption with samba 3.0.2a
Date: Wed, 18 Feb 2004 15:08:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <Sea2-DAV57V87PdIv650000b53f@hotmail.com>
X-OriginalArrivalTime: 18 Feb 2004 14:08:22.0984 (UTC) FILETIME=[AB50F480:01C3F628]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> Marco Berizzi writes:
>  > Hello.
>  > 
>  > I'm experimenting this problem with samba 3.0.2a and linux 2.4.24
>  > with ReiserFS. When I copy (put) a large file (5GB) from a Windows NT
>  > terminal server edition sp6a machine to the samba-linux box I get this
>  > error:
>  > 
>  > Feb 17 18:01:11 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:4999052)[dev:blocknr]: bit already cleared
>  > Feb 17 18:01:11 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:4997935)[dev:blocknr]: bit already cleared
>  > Feb 17 18:02:48 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:902445)[dev:blocknr]: bit already cleared
>  > Feb 17 18:02:48 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:902286)[dev:blocknr]: bit already cleared
>  > 
> 
> Are there any other error messages before these?

No, no errors before these.

>  > Samba 2.2.8a doesn't show this behaviour.
>  > 
>  > The linux box is Slackware 9.1 (gcc 3.2.3 linux 2.4.24 glibc 2.3.2).
>  > It's easy for me to reproduce the problem.
>  > 
>  > Hints?
> 
> Did target file exist before copy?

No. The directory was clean.
