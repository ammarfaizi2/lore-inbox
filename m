Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270440AbTGaRgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270478AbTGaRgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:36:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41484 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270440AbTGaRgg (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Thu, 31 Jul 2003 13:36:36 -0400
Date: Thu, 31 Jul 2003 10:34:33 -0700
From: Greg KH <greg@kroah.com>
To: Tomasz Torcz <zdzichu@irc.pl>, LKML <linux-kernel@vger.redhat.com>
Subject: Re: 2.6.0-test2, sensors and sysfs
Message-ID: <20030731173433.GA3644@kroah.com>
References: <20030731172141.GA6298@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731172141.GA6298@irc.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 07:21:41PM +0200, Tomasz Torcz wrote:
> 
> On Flameeyes wrote:
> > I tried either with i2c-viapro and via686a as modules, and built-in in
> > kernel. Nothing changes. Also dmesg doesn't output anything.
> > I have missed something?
> 
> Be aware that via686 (and i2c-isa and probably others) do not work
> when compiled into kernel. It must me in a module.

Why?  They should work the same, if not, it's a bug.

thanks,

greg k-h
