Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281890AbRKSGTC>; Mon, 19 Nov 2001 01:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281891AbRKSGSn>; Mon, 19 Nov 2001 01:18:43 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:43272 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281890AbRKSGSd>;
	Mon, 19 Nov 2001 01:18:33 -0500
Date: Mon, 19 Nov 2001 17:16:53 +1100
From: Anton Blanchard <anton@samba.org>
To: Lee Chin <leechinus@yahoo.com>
Cc: "linux, kernel" <linux-kernel@vger.kernel.org>,
        Linux Net <linux-net@vger.kernel.org>
Subject: Re: sendfile from sockets
Message-ID: <20011119171653.E6367@krispykreme>
In-Reply-To: <20011119060850.53289.qmail@web14311.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011119060850.53289.qmail@web14311.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Although the man page says you can sendfile from a
> socket,I am unable to do so... I can only send file
> from a file, to either a socket or file
> 
> Is this a kernel limitation?

Yes, the manpage needs updating, you can only sendfile() from
something that exists in the pagecache (ie not a socket).

Anton
