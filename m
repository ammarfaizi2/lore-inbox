Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTJGWB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbTJGWB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:01:28 -0400
Received: from mail45-s.fg.online.no ([148.122.161.45]:27054 "EHLO
	mail45.fg.online.no") by vger.kernel.org with ESMTP id S262766AbTJGWB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:01:27 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com>
	<200310072128.09666.insecure@mail.od.ua>
	<20031007194124.GA2670@kroah.com>
	<200310072347.41749.insecure@mail.od.ua>
	<20031007205244.GA2978@kroah.com>
	<yw1xvfr0wxfa.fsf@users.sourceforge.net>
	<20031007213758.GB3095@kroah.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 08 Oct 2003 00:01:23 +0200
In-Reply-To: <20031007213758.GB3095@kroah.com> (Greg KH's message of "Tue, 7
 Oct 2003 14:37:58 -0700")
Message-ID: <yw1xr81owvv0.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>> It's been my understanding that udev creates device nodes in a regular
>> filesystem.  If this is the case, things like unclean reboots will
>> leave stale files behind.  It will also not be easy to
>> bootstrap. Correct me if am wrong.
>
> mount -t ramfs none /dev
>
> That is what udev will run off of :)

There will still have to be some static device files to get the system
booted, right?  init usually is rather unhappy if it can't find
/dev/console.

> Again, can you point me to any documentation that states that udev will
> do this on a persistant filesystem?

Can you point me to any documentation at all?

-- 
Måns Rullgård
mru@users.sf.net
