Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289142AbSAWGUk>; Wed, 23 Jan 2002 01:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289291AbSAWGUa>; Wed, 23 Jan 2002 01:20:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10176 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289142AbSAWGUL>;
	Wed, 23 Jan 2002 01:20:11 -0500
Date: Tue, 22 Jan 2002 22:17:51 -0800 (PST)
Message-Id: <20020122.221751.45130206.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0201221902250.2262-100000@freak.distro.conectiva>
In-Reply-To: <20020122220046.C21383@flint.arm.linux.org.uk>
	<Pine.LNX.4.21.0201221902250.2262-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Tue, 22 Jan 2002 19:03:04 -0200 (BRST)

   On Tue, 22 Jan 2002, Russell King wrote:
   
   > Can you enlighten us as to why it is "not needed" ?  I haven't seen any
   > followups from Andi nor Davem to saying that.
   
   David told me the patch is not needed and only 2.2.x and 2.4.0-pre are
   affected.
   
    David? 
   
Correct.  The 2.3.x/2.4.x branch of the code had the fix made in
revision 1.71 of net/ipv4/icmp.c which equates to August 8th, 2000
which equates to 2.4.0-test6-pre2 or -pre3. :-)

On the 2.2.x side, 2.2.18 has the fix.  There is one, and only one
change, in that patch, to the file net/ipv4/icmp.c and it is the
fix in question.

It is really unfortunate that the bugtraq reporter failed to even
bother to mention what kernel he was using.  It could have avoided a
lot of the confusion surrounding this (already fixed) bug.
