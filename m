Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268091AbTBRXBU>; Tue, 18 Feb 2003 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268098AbTBRXBT>; Tue, 18 Feb 2003 18:01:19 -0500
Received: from 0wned.org ([207.164.207.21]:36357 "EHLO nitro.0wned.org")
	by vger.kernel.org with ESMTP id <S268091AbTBRW7o>;
	Tue, 18 Feb 2003 17:59:44 -0500
From: George Staikos <staikos@kde.org>
To: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: Select voltage manually in cpufreq
Date: Tue, 18 Feb 2003 18:09:34 -0500
User-Agent: KMail/1.5
References: <20030218214220.GA1058@elf.ucw.cz> <20030218214726.GB15007@f00f.org>
In-Reply-To: <20030218214726.GB15007@f00f.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302181809.34537.staikos@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 February 2003 16:47, Chris Wedgwood wrote:
> On Tue, Feb 18, 2003 at 10:42:20PM +0100, Pavel Machek wrote:
> > I've added possibility to manualy force specified frequency and
> > voltage... That's fairly usefull for testing, and I believe this (or
> > something equivalent) is needed because every 2nd bios seems to be
> > b0rken.
>
> Why are all the power/cpu patches so complex?  Can't we have a
> two-mode style operation, "slow-low-power" and "fast-high-power" or
> something?  Would that not work with 99% or what people need and also
> be somewhat more uniform across platforms, CPUs, etc?

  I think the important thing is for the kernel to provide the functionality 
that 99% of the people will need, and then for userspace tools/daemons to 
hide the complex portions and make it easy for a user to get what he wants.

   /proc is not nearly a valid user interface, but it is one of the 
application interfaces.

-- 

George Staikos

