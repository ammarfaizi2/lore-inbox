Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRKSIAj>; Mon, 19 Nov 2001 03:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRKSIA3>; Mon, 19 Nov 2001 03:00:29 -0500
Received: from web14303.mail.yahoo.com ([216.136.173.79]:53818 "HELO
	web14303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273305AbRKSIAN>; Mon, 19 Nov 2001 03:00:13 -0500
Message-ID: <20011119080012.75161.qmail@web14303.mail.yahoo.com>
Date: Mon, 19 Nov 2001 00:00:12 -0800 (PST)
From: Lee Chin <leechinus@yahoo.com>
Subject: Re: sendfile from sockets
To: Anton Blanchard <anton@samba.org>
Cc: "linux, kernel" <linux-kernel@vger.kernel.org>,
        Linux Net <linux-net@vger.kernel.org>
In-Reply-To: <20011119171653.E6367@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do I need to do something special to enable sendfile
in the kernel?  It works on a 2.2 kernel, but not on a
2.4 kernel (and this is sendfile in general... not
just sockets)

Thanks
Lee
--- Anton Blanchard <anton@samba.org> wrote:
> 
> > Although the man page says you can sendfile from a
> > socket,I am unable to do so... I can only send
> file
> > from a file, to either a socket or file
> > 
> > Is this a kernel limitation?
> 
> Yes, the manpage needs updating, you can only
> sendfile() from
> something that exists in the pagecache (ie not a
> socket).
> 
> Anton


__________________________________________________
Do You Yahoo!?
Find the one for you at Yahoo! Personals
http://personals.yahoo.com
