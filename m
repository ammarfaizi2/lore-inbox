Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUHSPMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUHSPMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUHSPJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:09:36 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:29639 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266509AbUHSPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:07:13 -0400
Date: Thu, 19 Aug 2004 17:07:04 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Martin Mares <mj@ucw.cz>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
       diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040819150704.GB1659@merlin.emma.line.org>
Mail-Followup-To: Martin Mares <mj@ucw.cz>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
	diablod3@gmail.com
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz> <4124AD46.nail80H216HKB@burner> <20040819135614.GA12634@ucw.cz> <4124B314.nail8221CVOE9@burner> <20040819141442.GC13003@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040819141442.GC13003@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Martin Mares wrote:

> That's really hard to believe, but on the other hand, when packaging
> my programs, SUSE people were always cooperating very well.

It depends on whom you talk to. The generic feedback ways don't work
well at all, 80% of issues are apparently dropped, no chance to query
status from the outside, and it takes ages until something happens.

> So, let's ask the SUSE'rs around there: is there any problem with adding such
> a notice to the cdrecord package?

Non-issue.  SuSE 9.1 PRO:

$ rpm -qf /usr/bin/cdrecord
cdrecord-2.01a27-21
$ /usr/bin/cdrecord -version
ZY�$: Operation not permitted. WARNING: Cannot set RR-scheduler
ZY�$: Permission denied. WARNING: Cannot set priority using setpriority().
ZY�$: WARNING: This causes a high risk for buffer underruns.
Cdrecord-Clone-dvd 2.01a27 (i686-suse-linux) Copyright (C) 1995-2004 Jörg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to http://www.suse.de/feedback
Note: The author of cdrecord should not be bothered with problems in this version.

BTW:

$ /opt/schily/bin/cdrecord -version
Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004 J�rg Schilling
/opt/schily/bin/cdrecord: Warning: Running on Linux-2.6.8.1
/opt/schily/bin/cdrecord: There are unsettled issues with Linux-2.5 and newer.
/opt/schily/bin/cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.

I read the discussion as though these issues had been settled with
Linux 2.6.8. Is 2.01a37 too old to be aware of the fix or is there an
issue left with finding the "right" header files?

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
