Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTAIBCl>; Wed, 8 Jan 2003 20:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbTAIBCl>; Wed, 8 Jan 2003 20:02:41 -0500
Received: from [213.228.128.91] ([213.228.128.91]:11659 "HELO
	front3.netvisao.pt") by vger.kernel.org with SMTP
	id <S261205AbTAIBCk>; Wed, 8 Jan 2003 20:02:40 -0500
Subject: RE: modutils x 2.5.54
From: "Paulo Andre'" <fscked@netvisao.pt>
To: linux-kernel@vger.kernel.org
In-Reply-To: <001701c2b77a$18336630$6601a8c0@s3ac>
References: <001701c2b77a$18336630$6601a8c0@s3ac>
Content-Type: text/plain
Organization: Corleone Hacking Corp.
Message-Id: <1042074675.28495.4.camel@nostromo.orion.int>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 01:11:15 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 00:57, studio3arc.com Admin wrote:
> > modprobe --version
> > gives me 0.9.5.
> > 
> > lsmod and insmod don't support --version.
> > 
> 
> I get the following 2.4.12 !?!? Now I'm very confused
> 
> 
> s3a-www:/usr/src/linux-2.4.18.SuSE # modprobe --version
> modprobe version 2.4.12
> modprobe: Nothing to load ???
> Specify at least a module or a wildcard like \*
> s3a-www:/usr/src/linux-2.4.18.SuSE #

If you are running a 2.5 kernel then it seems you didn't install the
module-init-tools correctly. It's supposed to install the newer utils as
modutils, lsmod, insmod etc.. and backups the old modutils as
modprobe.old, lsmod.old, insmod.old and so on. 

Either that or you are running a 2.4 kernel, in which case the output is
correct (or so it seems).

	Paulo

