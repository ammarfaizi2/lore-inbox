Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSJaSGQ>; Thu, 31 Oct 2002 13:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSJaSFX>; Thu, 31 Oct 2002 13:05:23 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:27576 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S262722AbSJaSFF>; Thu, 31 Oct 2002 13:05:05 -0500
Subject: Re: [PATCH] 2.5.45: Filesystem capabilities
From: Dax Kelson <dax@gurulabs.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <87znsuy9ho.fsf@goat.bogus.local>
References: <87znsuy9ho.fsf@goat.bogus.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 11:11:50 -0700
Message-Id: <1036087911.2296.19.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 07:21, Olaf Dietsche wrote:
> Hi Linus,
> 
> This patch implements filesystem capabilities. It allows to run
> privileged executables without the need for suid root.
> 
> Changes:
> - switched from 32 bits to 128 bits for capabilities
> 
> I have addressed all objections Al Viro has raised. However, this is
> not widely tested so far. But this is a relative small patch, so it
> shouldn't be too hard to remove it later, if it turns out to be too
> dangerous, either security or file system wise.
> 
> Please include.
> 
> Regards, Olaf.

I second this!

I would very very much like to purge my systems of SUID root binaries. 

If this goes in, we/I should start a little project to audit the SUID
root binaries commonly found on Linux to see what are the minimum
capabilities each binary needs.

Ideally the distro then ship this way by default.

RPM/DPKG (tar,cpio?) should be modified to store the capabilities too.

Dax Kelson
Guru Labs



