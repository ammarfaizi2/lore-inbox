Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRJaBFk>; Tue, 30 Oct 2001 20:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278813AbRJaBFa>; Tue, 30 Oct 2001 20:05:30 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:64274 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S278810AbRJaBFU>; Tue, 30 Oct 2001 20:05:20 -0500
Date: Wed, 31 Oct 2001 02:05:38 +0100
From: Kurt Roeckx <Q@ping.be>
To: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011031020538.A354@ping.be>
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au>; from iml@ilm.mech.unsw.edu.au on Wed, Oct 31, 2001 at 11:33:12AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 11:33:12AM +1100, Ian Maclaine-cross wrote:
> 
> PROBLEM: Linux updates RTC secretly when clock synchronizes.
> 
> When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
> using the Network Time Protocol the kernel time is accurate to a few
> milliseconds. Linux then sets the Real Time (or Hardware or CMOS)
> Clock to this time at approximately 11 minute intervals. Typical RTCs
> drift less than 10 s/day so rebooting causes only millisecond errors.


This is all in the manpage, see man hwclock.  If you use ntpd,
you probably don't want hwclock to adjust, just set the time.


Kurt

