Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbTAMIaW>; Mon, 13 Jan 2003 03:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTAMIaW>; Mon, 13 Jan 2003 03:30:22 -0500
Received: from ns1.ealliance.ro ([213.233.121.14]:41110 "HELO ealliance.ro")
	by vger.kernel.org with SMTP id <S267364AbTAMIaW> convert rfc822-to-8bit;
	Mon, 13 Jan 2003 03:30:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mihnea Balta <dark_lkml@mymail.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel hooks just to get rid of copy_[to/from]_user() and syscall overhead?
Date: Mon, 13 Jan 2003 10:37:52 +0200
X-Mailer: KMail [version 1.4]
References: <200301101645.39535.dark_lkml@mymail.ro>
In-Reply-To: <200301101645.39535.dark_lkml@mymail.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131037.52504.dark_lkml@mymail.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 January 2003 16:45, Mihnea Balta wrote:
> Hi,
>
> I have to implement a system which grabs udp packets off a gigabit
> connection, take some basic action based on what they contain, repack their
> data with a custom protocol header and send them through a gigabit ethernet
> interface on broadcast.

Thank you to everybody who answered, I'll try the mmap()ed descriptor 
userspace solution, as it seems good enough.

