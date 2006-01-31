Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWAaEPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWAaEPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 23:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWAaEPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 23:15:24 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:2010 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1030224AbWAaEPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 23:15:23 -0500
From: Dave Peterson <dsp@llnl.gov>
To: ebiederman@lnxi.com (Eric W. Biederman)
Subject: Re: noisy edac
Date: Mon, 30 Jan 2006 20:15:13 -0800
User-Agent: KMail/1.5.3
Cc: Gunther Mayer <gunther.mayer@gmx.net>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com> <200601301653.15984.dsp@llnl.gov> <m3zmldjd31.fsf@maxwell.lnxi.com>
In-Reply-To: <m3zmldjd31.fsf@maxwell.lnxi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601302015.13057.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 19:22, Eric W. Biederman wrote:
> One piece missing from this conversation is the issue that we need errors
> in a uniform format.  That is why edac_mc has helper functions.
>
> However there will always be errors that don't fit any particular model.
> Could we add a edac_printk(dev, );  That is similar to dev_printk but
> prints out an EDAC header and the device on which the error was found?
> Letting the rest of the string be user specified.

I like this idea.  It would facilitate grepping in logfiles for
EDAC-related errors.
