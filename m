Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVEOLzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVEOLzL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 07:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVEOLzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 07:55:11 -0400
Received: from web60514.mail.yahoo.com ([209.73.178.177]:64390 "HELO
	web60514.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262787AbVEOLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 07:55:03 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=LoPQnyxWnCekqmtaqyDrOAaIIjRDVverjyfyu/veE2WJDDlNohNeZOoMUEExubM40zPuc3wnONbcp8v3OoeJPsxRP3PhrqWuddqgev0i/8fQt5yO+/47F18kuiGDzZQn88qFnt74SsdfKcvrHttWoSL9o3A1D9zOz83+rOoKFuE=  ;
Message-ID: <20050515115459.55864.qmail@web60514.mail.yahoo.com>
Date: Sun, 15 May 2005 04:54:59 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: oprofile: enabling cpu events
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Baruch Even <baruch@ev-en.org>, linux <linux-kernel@vger.kernel.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Philippe,
You are right, it seems that apci is off by default.
How to turn it on ?
the flags in /proc/cpuinfo does not show acpi
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 3
cpu MHz         : 450.008
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 886.78

--- Philippe Elie <phil.el@wanadoo.fr> wrote:
> On Sun, 08 May 2005 at 00:20 +0000, li nux wrote:
> 
> > Thanks Baruch,
> > # opcontrol --setup  --event=CPU_CLK_UNHALTED
> >  You cannot specify any performance counter events
> >  because OProfile is in timer mode.
>  
> 
> check if local apic support is turned on.
> 
> Philippe Elie
> 



		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html

