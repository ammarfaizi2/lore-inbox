Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTDSUqH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTDSUqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:46:07 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:17165 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263462AbTDSUqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:46:06 -0400
Date: Sat, 19 Apr 2003 22:59:46 +0200
To: Christian Staudenmayer <eggdropfan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-ac2 and lilo
Message-ID: <20030419205946.GB15577@hh.idb.hist.no>
References: <20030419170725.35871.qmail@web41812.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419170725.35871.qmail@web41812.mail.yahoo.com>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 10:07:25AM -0700, Christian Staudenmayer wrote:
> Hello,
> 
> i'm running a machine that uses the aic7xxx driver for the old adaptec 2940 scsi
> controller. i had problems with getting 2.5.67-ac2 to run, it used to end in
> a kernel panic. i got told to remove the body of the function ide_xlate_1024
> by just "return 0;", which fixed the problem, i could then boot the kernel.
> but now, when running lilo, i get the following message:

Weird - the 2940 is scsi so how come ide is involved?
I use mine for a cdrom.  I had to use the old aic7xxx driver,
the new one didn't detect the cdrom.
It works fine with 2.5.67 and 2.5.67-mm4
 
Helge Hafting
