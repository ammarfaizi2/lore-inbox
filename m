Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTJGV1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTJGV1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:27:45 -0400
Received: from main.gmane.org ([80.91.224.249]:32488 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262878AbTJGV1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:27:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: devfs and udev
Date: Tue, 07 Oct 2003 23:27:37 +0200
Message-ID: <yw1xvfr0wxfa.fsf@users.sourceforge.net>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <200310072128.09666.insecure@mail.od.ua>
 <20031007194124.GA2670@kroah.com> <200310072347.41749.insecure@mail.od.ua>
 <20031007205244.GA2978@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:PbhEEBKnPuzKuUjzpjE81e9MmCc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>> > > What am I supposed to do, starting to use mknod again? Uggggh...
>> >
>> > Provide me with a kernel name to devfs name mapping file so that I can
>> > create a "devfs like" udev config file for people who happen to like
>> > that naming scheme.
>> 
>> It seems that we have a bit of misunderstanding here.
>> 
>> I just don't want to go back to /dev being actually placed on
>> real, on-disk fs.
>> 
>> I won't mind if naming scheme will change as long
>> as device names start with '/dev/' and appear
>> there (semi-)automagically. That's what I call devfs.
>> If udev can do this, I am all for that.
>
> udev can do this.  Is there some documentation that you read that has
> suggested otherwise?

It's been my understanding that udev creates device nodes in a regular
filesystem.  If this is the case, things like unclean reboots will
leave stale files behind.  It will also not be easy to
bootstrap. Correct me if am wrong.

-- 
Måns Rullgård
mru@users.sf.net

