Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWA3XwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWA3XwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWA3XwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:52:20 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:49138 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S965045AbWA3XwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:52:19 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Gunther Mayer <gunther.mayer@gmx.net>
Subject: Re: noisy edac
Date: Mon, 30 Jan 2006 15:52:09 -0800
User-Agent: KMail/1.5.3
Cc: "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com> <200601301424.16884.dsp@llnl.gov> <43DEA4CA.8070700@gmx.net>
In-Reply-To: <43DEA4CA.8070700@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301552.09955.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 15:44, Gunther Mayer wrote:
> >For each individual type of error that is specific to a particular
> >low-level chipset driver (e752x, amd76x, etc.) there could be an entry
> >in the appropriate part of the sysfs hierarchy under the given chipset
> >driver.  This entry could have several settings that the user may choose
> >from such as { ignore, syslog, panic }.  For the implementation, there
> >could be a generic piece of code in the core EDAC module that a chipset
> >driver calls into.  The generic code would do the dirty work of creating
> >the sysfs entries (and destroying them when the chipset module is
> >unloading).  How does this sound?
>
> Over-Engineered.

Do you have an alternate suggestion?
