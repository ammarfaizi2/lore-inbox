Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267746AbTATBlU>; Sun, 19 Jan 2003 20:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbTATBlU>; Sun, 19 Jan 2003 20:41:20 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:26752 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S267746AbTATBlT>;
	Sun, 19 Jan 2003 20:41:19 -0500
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15915.21051.365166.964932@charged.uio.no>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	 <15915.21051.365166.964932@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043027422.668.4.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 02:50:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 02:34, Trond Myklebust wrote:
> >>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:
> 
>      > I've mounted the rpc_pipefs filesystem and the directory
>      > portmap/clntcfac0540 is created. It's empty but created.  It
>      > gets created with 500 as permissions.
> 
> Ah... Can this be the same problem as before? Try this...

Now the directories under portmap/ are created with 555 permissions but
I still get the exact same messages and the directories are still empty
except for this weird thing:

# ls portmap/clnteb2bbc7c   
info

# ls  portmap/clnteb2bbc7c -l
ls: portmap/clnteb2bbc7c/info: No such file or directory
total 0


-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
