Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273809AbRIXG2r>; Mon, 24 Sep 2001 02:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273812AbRIXG2h>; Mon, 24 Sep 2001 02:28:37 -0400
Received: from codepoet.org ([166.70.14.212]:63039 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S273809AbRIXG2Z>;
	Mon, 24 Sep 2001 02:28:25 -0400
Date: Mon, 24 Sep 2001 00:28:54 -0600
From: Erik Andersen <andersen@codepoet.org>
To: David Woodhouse <dwmw2@cambridge.redhat.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
Message-ID: <20010924002854.A25226@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David Woodhouse <dwmw2@cambridge.redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <16995.1001284442@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16995.1001284442@redhat.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Sep 23, 2001 at 11:34:02PM +0100, David Woodhouse wrote:
> 
> torvalds@transmeta.com said:
> > In addition to the VM changes that have gotten so much attention there
> > are architecture updates, various major filesystem updates (jffs2 and
> > NTFS),
> 
> JFFS2 can't actually be built at the moment because the magic in 
> fs/Makefile and fs/Config.in appears to be absent. The fix for that is
> about number 20 in the patchbomb I'm currently preparing.
> 
> The terminally impatient can find the whole patch, before I finish removing 
> some of the backward-compatibility crap, at 
> 	ftp.uk.linux.org:/pub/people/dwmw2/mtd/mtd-diff-against-2.4.10-v2

Is jffs2 still showing the
    Child dir "." (ino #1) of dir ino #1 appears to be a hard link
problem?  I saw you patched mkfs.jffs2 after my changes -- do you
still need me to hunt down that bug I added?

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
