Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291043AbSBLNmB>; Tue, 12 Feb 2002 08:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291048AbSBLNlx>; Tue, 12 Feb 2002 08:41:53 -0500
Received: from unicef.org.yu ([194.247.200.148]:2830 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S291043AbSBLNle>;
	Tue, 12 Feb 2002 08:41:34 -0500
Date: Tue, 12 Feb 2002 14:41:19 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: secure erasure of files?
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there is srm (secure rm) somewhere on the net
here srm.sourceforge.net
srm - secure file deletion for posix systems

happy srm,

      Zoran

   srm is a secure replacement for rm(1). Unlike the standard rm, it
   overwrites the data in the target files before unlinking them. This
   prevents command-line recovery of the data by examining the raw block
   device. It may also help frustrate physical examination of the disk,
   although it's unlikely that it can completely prevent that type of
   recovery. It is, essentially, a paper shredder for sensitive files.

   srm is ideal for personal computers or workstations with Internet
   connections. It can help prevent malicious users from breaking in and
   undeleting personal files, such as old emails. It's also useful for
   permanently removing files from expensive media. For example, cleaning
   your diary off the zip disk you're using to send vacation pictures to
   Uncle Lou. Because it uses the exact same options as rm(1), srm is
   simple to use. Just subsitute it for rm whenever you want to destroy
   files, rather than just unlinking them.


On Tue, 12 Feb 2002, Roy Sigurd Karlsbakk wrote:

> Date: Tue, 12 Feb 2002 14:12:49 +0100 (CET)
> From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
> To: linux-kernel@vger.kernel.org
> Subject: secure erasure of files?
>
> hi all
>
> Does anyone know if it'll be hard to enable a <em>secure</em> deletion of
> files? What I mean is not merely overwriting it with NULLs, but rather
> using a more sophisticated overwrite, like the IBAS ExpertEraser software
> (http://www.ibas.com/erasure/)
>
> Is this hard/possible/doable?
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
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

