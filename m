Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSI3JLR>; Mon, 30 Sep 2002 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261976AbSI3JLQ>; Mon, 30 Sep 2002 05:11:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53253 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261973AbSI3JLP>; Mon, 30 Sep 2002 05:11:15 -0400
Message-Id: <200209300911.g8U9BKp18642@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: jw schultz <jw@pegasys.ws>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice driver
Date: Mon, 30 Sep 2002 12:05:22 -0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0209262140380.1655-100000@home.transmeta.com> <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain> <20020928091634.GC32017@pegasys.ws>
In-Reply-To: <20020928091634.GC32017@pegasys.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 September 2002 07:16, jw schultz wrote:
> Ingo, I agree with Linus.  My recollection of when we moved
> to 2.0 was that the major number reflected the user<->kernel
> ABI.  I have no problem with a version 2.42 if things stay
> stable that long.   I hope they don't but that is another
> issue.
>
> Version 3.0 implies incompatibility with binaries from 2.x
> The distributions can play around with version numbers
> reflecting the GUI interface, libraries or installers but
> the kernel major version should stay the same until binary
> compatibility is broken.  When we move old syscalls (such as
> 32 bit file ops) from deprecated to unsupported is when we
> increment the major number.
>
> It may be that 2.7 will see the cruft cut out and be the end
> of 2.x but 2.5 isn't that.  So far 2.5 is performance
> enhancement.  Terrific performance enhancement, thanks to you
> and many others.  But it isn't adding major new features nor
> is it removing old interfaces.  In many ways 2.6 looks like
> a sign that the 2.x kernel is getting mature.  2.6 means
> users can expect improvements but don't have to make big changes.
> 2.6 is an upgrade, 3.0 would be a replacement.

Technically correct. Major version jump should be made when there is
a binary incompatibility. It can be made without, but it is usually
done for marketing reasons. I hope we'll never have marketing reasons
for lk. :-) We can be actually _proud_ to have 2.$BIGNUM instead of
3.0
--
vda
