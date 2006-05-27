Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWE0Kg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWE0Kg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWE0Kg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 06:36:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:63405 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751459AbWE0Kg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 06:36:27 -0400
From: Neil Brown <neilb@suse.de>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Date: Sat, 27 May 2006 20:36:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17528.11171.347324.526827@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
In-Reply-To: message from Thomas Glanzmann on Saturday May 27
References: <4477B905.9090806@garzik.org>
	<Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
	<20060527102439.GB26430@cip.informatik.uni-erlangen.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 27, sithglan@stud.uni-erlangen.de wrote:
> Hello,
> 
> > #!/usr/bin/perl -i -p
> > s/[ \t\r\n]+$//
> 
> perl -p -i -e 's/\s+$//' file1 file2 file3 ...
> 

Uhm... have either of you actually tried those?  When I tried, I lose
all the '\n' characters :-(

  perl -pi -e 's/[ \t\r]+$//'  *.[ch]

seems to actually work.

NeilBrown
