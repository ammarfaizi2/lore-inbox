Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131027AbRCJQOs>; Sat, 10 Mar 2001 11:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRCJQOi>; Sat, 10 Mar 2001 11:14:38 -0500
Received: from s057.dhcp212-109.cybercable.fr ([212.198.109.57]:65029 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131027AbRCJQOY>; Sat, 10 Mar 2001 11:14:24 -0500
Message-ID: <3AAA5273.67DC90EF@baretta.com>
Date: Sat, 10 Mar 2001 17:12:35 +0100
From: Alex Baretta <alex@baretta.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug with poll syscall
In-Reply-To: <3AAA2ADE.E8FF41E3@baretta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Baretta wrote:
> 
> I am using poll with the POLLIN flag to wait for connection
> requests on a set of listening sockets in a server process.
> Although clients attempt to connect to those sockets, poll does
> returns zero after the expiration of the timeout.


The very same thing happens if I use select. It seems highly
unlikely that this should be the specified behavior of poll and
select alike. Is one now forced to used threads to manage multiple
ports?

Greetings,

Alex Baretta
