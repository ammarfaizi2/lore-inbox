Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSAPRTQ>; Wed, 16 Jan 2002 12:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbSAPRTG>; Wed, 16 Jan 2002 12:19:06 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:41905 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S280588AbSAPRS5>; Wed, 16 Jan 2002 12:18:57 -0500
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <Pine.LNX.4.33.0201152009030.12670-100000@twinlark.arctic.org>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 16 Jan 2002 18:18:40 +0100
Message-ID: <871ygqkydr.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet <dean-list-linux-kernel@arctic.org> writes:

> On 15 Jan 2002, Olaf Dietsche wrote:
> 
> > For example, you can say, user www is allowed to bind to port 80 or
> > user mail is allowed to bind to port 25. Then, you can run apache as
> > user www and sendmail as user mail. Now, you don't have to rely on
> > apache or sendmail giving up superuser rights to enhance security.
> 
> typically logging must also occur as some other user than what the daemon
> runs as, or else your logs are suspect in any sort of break-in.  this is
> no problem for stuff using syslog, but since that's not the default
> configuration for apache you might want to put a note in any docs you end
> up including.  one suggestion is piped logging through a setuid logger
> (setuid to user wwwlogs or something, root not required).

Right. But that's user space and shouldn't impact the kernel/accessfs.
Or did I miss something?

Regards, Olaf.
