Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRCJNZv>; Sat, 10 Mar 2001 08:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRCJNZl>; Sat, 10 Mar 2001 08:25:41 -0500
Received: from s057.dhcp212-109.cybercable.fr ([212.198.109.57]:54788 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129388AbRCJNZb>; Sat, 10 Mar 2001 08:25:31 -0500
Message-ID: <3AAA2ADE.E8FF41E3@baretta.com>
Date: Sat, 10 Mar 2001 14:23:42 +0100
From: Alex Baretta <alex@baretta.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Possible bug with poll syscall
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using poll with the POLLIN flag to wait for connection
requests on a set of listening sockets in a server process.
Although clients attempt to connect to those sockets, poll does
returns zero after the expiration of the timeout. I believe this
might be a bug. As far as I understand poll should be woken up by
connection requests and should signal them with a POLLIN. But,
then again, I might have misunderstood the specification.

Would anyone please shed some light on this issue?

Thank you very much.

Alex Baretta
