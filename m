Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279930AbRKKRvK>; Sun, 11 Nov 2001 12:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279937AbRKKRvB>; Sun, 11 Nov 2001 12:51:01 -0500
Received: from web11701.mail.yahoo.com ([216.136.172.67]:27541 "HELO
	web11701.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279930AbRKKRux>; Sun, 11 Nov 2001 12:50:53 -0500
Message-ID: <20011111175053.96626.qmail@web11701.mail.yahoo.com>
Date: Sun, 11 Nov 2001 09:50:53 -0800 (PST)
From: Sean Elble <s_elble@yahoo.com>
Subject: Re: Is ReiserFS stable?
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111111518420.15062-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That all depends on what you mean by "stable". Reiser
is certainly capable of high uptimes, but Reiser
doesn't have a good history of working well with older
UNIX tools/systems like NFS, due to Reiser's newer
methods for handling inodes and such. If this isn't a
problem for you, Reiser should work very well for you;
it works great on my /var partition, which handles my
Squid proxy. I don't use Reiser on my /home partition
though; that FS has the user directories exported
through NFS, as well as Samba. In fact, I use SGI's
XFS on my /home partition, and that works well too.
The main advantage to using XFS is that it handles NFS
_really_ well, and it has certain features Reiser
doesn't, like extended attributes, and access control
lists. YMMV, but Reiser seems stable for just that one
specific duty . . . I'd recommend trying Reiser, JFS,
XFS, and maybe even Ext3 to get a feel for how stable
each is for your particular needs. HTH.
--- Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
> Hi all
> 
> I've heard a lot of talk from all sorts of people
> about ReiserFS not being
> stable enough to use in a productional environment
> where high uptime is
> essensial.
> 
> Can someone tell me if this is true?
> 
> Thanks
> 
> roy
> 
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> 
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


=====
-----------------------------------------------
Sean P. Elble
Editor, Writer, Co-Webmaster
ReactiveLinux.com (Formerly MaximumLinux.org)
http://www.reactivelinux.com/
elbles@reactivelinux.com
-----------------------------------------------

__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
