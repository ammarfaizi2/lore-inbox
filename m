Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRBJXhq>; Sat, 10 Feb 2001 18:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRBJXhg>; Sat, 10 Feb 2001 18:37:36 -0500
Received: from oberon.gaumina.lt ([193.219.244.227]:57866 "HELO
	oberon.gaumina.lt") by vger.kernel.org with SMTP id <S129777AbRBJXhY> convert rfc822-to-8bit;
	Sat, 10 Feb 2001 18:37:24 -0500
From: Andrius Adomaitis <charta@gaumina.lt>
To: David Ford <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Date: Sun, 11 Feb 2001 01:36:20 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <E14RbJG-0001ds-00@the-village.bc.nu> <3A85AFC8.9070107@blue-labs.org>
In-Reply-To: <3A85AFC8.9070107@blue-labs.org>
MIME-Version: 1.0
Message-Id: <01021101362000.00498@castle.gaumina.lt>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 February 2001 22:16, David Ford wrote:

> Just as an aside, I've watched this conversation go on and on while I
> run reiserfs on several servers, workstations, and a notebook.  I
> have current kernels and have watched carefully for corruption.  I
> haven't seen any evidence of corruption on any of them including my
> notebook which has a bad battery and bad power connection so it tends
> to instantly die.
>
> Alan, is there a particular trigger to this?

Want to trigger this? Just install reiserfs on Dual SMP machine with 
huge RAID acting as mail server for 90k mailboxes. After several hours 
you'll get a lot reiserfs_read_inode2/reiserfs_iget: bad_inode msgs in 
your kern.log... 

Good luck.

--
Andrius
charta@gaumina.lt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
