Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUKNWqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUKNWqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUKNWqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:46:20 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:61958 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261363AbUKNWqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:46:09 -0500
Date: Sun, 14 Nov 2004 23:45:59 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Brad Fitzpatrick <brad@danga.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9: unkillable processes during heavy IO
Message-ID: <20041114224559.GB20151@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com> <20041114143051.33e2c514.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114143051.33e2c514.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 02:30:51PM -0800, Andrew Morton wrote:
> Brad Fitzpatrick <brad@danga.com> wrote:
> >
> > Next time it hangs like this, how can I get a kernel backtrace or other useful information
> >  for a certain process?
> 
> echo t > /proc/sysrq-trigger
> dmesg -n 1000000 > foo

I suppose you meant s/-n/-s/

With a recent dmesg (util-linux 2.12b or later) no parameter is needed.
