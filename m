Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWCOF6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWCOF6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbWCOF6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:58:34 -0500
Received: from xenotime.net ([66.160.160.81]:9966 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752083AbWCOF6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:58:33 -0500
Date: Tue, 14 Mar 2006 22:00:30 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: CIJOML <cijoml@volny.cz>
Cc: hager@cs.umu.se, linux-kernel@vger.kernel.org
Subject: Re: Dmesg is not showing whole boot list
Message-Id: <20060314220030.384dd29f.rdunlap@xenotime.net>
In-Reply-To: <200603150534.42245.cijoml@volny.cz>
References: <200603140901.27746.cijoml@volny.cz>
	<20060314083812.GA27338@brainysmurf.cs.umu.se>
	<200603150534.42245.cijoml@volny.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006 05:34:42 +0100 CIJOML wrote:

> This helped. 
> 
> Thanks
> 
> Michal

BTW, you don't have to recompile to get this.  You can also
add this to the kernel boot/command line:

	log_buf_len=n	Sets the size of the printk ring buffer, in bytes.
			Format: { n | nk | nM }
			n must be a power of two.  The default size
			is set in the kernel config file.


> Dne út 14. března 2006 09:38 jste napsal(a):
> > On Tue, Mar 14, 2006 at 09:01:27AM +0100, CIJOML wrote:
> > > Hello,
> > >
> > > maybe this si a wrong list to ask, bug after boot, dmesg shows that few
> > > lines at the beginning are missing.
> > >
> > > Is there any option I can increase to get full dmesg?
> >
> > Try increasing CONFIG_LOG_BUF_SHIFT and recompile. That's likely the
> > source of your problem.

---
~Randy
