Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbRBMMKS>; Tue, 13 Feb 2001 07:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129463AbRBMMKJ>; Tue, 13 Feb 2001 07:10:09 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:22776 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130320AbRBMMJ7>; Tue, 13 Feb 2001 07:09:59 -0500
Date: Tue, 13 Feb 2001 13:09:49 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: ketil@froyn.com
Cc: mas9483@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: gzipped executables
Message-ID: <20010213130949.A472@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010213084031.8598.qmail@www1.nameplanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010213084031.8598.qmail@www1.nameplanet.com>; from ketil@froyn.com on Tue, Feb 13, 2001 at 08:40:31AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 08:40:31AM -0000, ketil@froyn.com wrote:
> On Mon, 12 Feb 2001 23:09:39 -0600 (CST) Matt Stegman <mas9483@ksu.edu> wrote:
> >Is there any kernel patch that would allow Linux to properly recognize,
> >and execute gzipped executables?
> 
> Perhaps you could put it in the filesystem. Look at the
> "chattr" manpage, which shows how this is meant to work with
> ext2. It seems not to have been implemented yet. This way you
> could also compress any files, not just executables.

A nice way already implemented in 2.4.x is cramfs. Many embedded
people (like me) use it to fill up their flash disks.

Look at linux/Documentation/filesystems/cramfs.txt for more info.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
