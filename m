Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUAUVmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUAUVmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:42:05 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:18153 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S266022AbUAUVmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:42:01 -0500
Date: Wed, 21 Jan 2004 13:41:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Esben Stien <executiv@online.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: logging all input and output on a tty
Message-ID: <20040121214152.GO23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Esben Stien <executiv@online.no>,
	linux-kernel@vger.kernel.org
References: <87ad4h5juk.fsf@online.no> <1074708271.4724.5.camel@gax.mynet> <87u12p3s1e.fsf@online.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u12p3s1e.fsf@online.no>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 10:34:05PM +0100, Esben Stien wrote:
> Ludootje <ludootje@linux.be> writes:
> 
> > You can just cat the device, like cat /dev/tty<number>. So you can also
> > use normal redirectors (> , >> etc) or use a pager.
> 
> If I do cat /dev/tty1 on /dev/tty2, I see what I write to /dev/tty1 on /dev/tty2, but I don't see what I write to /dev/tty1 while working in /dev/tty1 (all the input is being printed on /dev/tty2) . And besides, I only see the input I type, not the output of f.ex a command (on /dev/tty2). I want to monitor users and log everything that is done on a specific tty when they log in. 

This is in debian:

Package: ttysnoop
Priority: optional
Section: admin
Installed-Size: 56
Maintainer: Alberto Gonzalez Iniesta <agi@agi.as>
Architecture: i386
Version: 0.12c-8
Depends: libc6 (>= 2.3.2-1)
Filename: pool/main/t/ttysnoop/ttysnoop_0.12c-8_i386.deb
Size: 15126
MD5sum: 462a28b83327bd2ae987791528e9e095
Description: TTY Snoop - allows you to spy on telnet+serial connections
 TTYSnoop allows you to snoop on login tty's through another tty-device or
 pseudo-tty. The snoop-tty becomes a 'clone' of the original tty,
 redirecting both input and output from/to it.

