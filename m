Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTHaPMU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbTHaPMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:12:20 -0400
Received: from mail.gmx.de ([213.165.64.20]:23502 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262482AbTHaPMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:12:18 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: Reiser4 snapshot problems
Date: Sun, 31 Aug 2003 17:12:17 +0200
User-Agent: KMail/1.5.9
References: <4834.1062157986@www16.gmx.net> <16207.18144.463818.473825@laputa.namesys.com>
In-Reply-To: <16207.18144.463818.473825@laputa.namesys.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308311712.17536.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 August 2003 14:28, Nikita Danilov wrote:
> Felix Seeger writes:
>  > Hi
>  >
>  > I am trying out Reiser4 snapshot from August 26th.
>  > I've putted my kde cvs sources on the new partition and compile from
>  > reiser4 now.
>  >
>  > After some time processes hang when accessing this disk. I cannot do
>  > anything on it but I also don't get any errormessage.
>
> If there anything in /var/log/messages, or wherever your kernel log is
> stored?

Ok, after playing around with umount and kill I finally got some error 
messages. Don't know if they are important:

 reiser4[ktxnmgrd:run(28206)]: commit_current_atom (fs/reiser4/txnmgr.c:1010)
[nikita-3176]:
WARNING: Flushing like mad: 16384
 reiser4[ktxnmgrd:run(28206)]: commit_current_atom (fs/reiser4/txnmgr.c:1010)
[nikita-3176]:
WARNING: Flushing like mad: 32768
 reiser4[ktxnmgrd:run(28206)]: commit_current_atom (fs/reiser4/txnmgr.c:1010)
[nikita-3176]:
WARNING: Flushing like mad: 65536
 reiser4[ktxnmgrd:run(28206)]: commit_current_atom (fs/reiser4/txnmgr.c:1010)
[nikita-3176]:
WARNING: Flushing like mad: 131072
 reiser4[ktxnmgrd:run(28206)]: commit_current_atom (fs/reiser4/txnmgr.c:1010)
[nikita-3176]:
WARNING: Flushing like mad: 262144
 reiser4[ktxnmgrd:run(28206)]: commit_current_atom (fs/reiser4/txnmgr.c:1010)
[nikita-3176]:
WARNING: Flushing like mad: 524288
 reiser4[ktxnmgrd:run(28206)]: commit_current_atom (fs/reiser4/txnmgr.c:1010)
[nikita-3176]:
WARNING: Flushing like mad: 1048576
...

>  > Umount, bash autocomletion and things like that don't work. Normal df
>  > and mount are working btw.
>
> Nikita.
Felix
