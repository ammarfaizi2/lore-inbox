Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUBNQEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUBNQEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:04:15 -0500
Received: from main.gmane.org ([80.91.224.249]:15001 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262126AbUBNQEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:04:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Implementing SQL on files
Date: Sat, 14 Feb 2004 17:04:07 +0100
Message-ID: <yw1xk72py7ew.fsf@kth.se>
References: <1076773002.20087.42.camel@aratnaweera.enetsl.virtusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-3502.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:04TW1I2CPJ0qzi3g9lw90cXr8AY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anuradha Ratnaweera <anuradha@linux.lk> writes:

> Hi all,
>
> I am starting to write some code to add a feature which I think would be
> very useful, and like to get comments and suggessions from LKML.  Please
> ignore this mail if it sounds like nonsense ;-)
>
> Also, if this is already happenning somewhere, please enlighten me.
>
> Short version: This feature will add a "table" file type and SQL
> executioin premitives to the kernel, and also relevent userspace
> programs.

Things like SQL belong in user space.


[...]

> Using the userspace tools, one can create a "table" file (say
> maintainers), and insert the data to that file.  Each file (or may be
> filesystem) has two characters (or strings) associated with them: field
> seperator and record seperator.  Say, colon and newline.  If I cat the
> file:
>
> % cat maintainers
> David Weinehall:2.0
> Alan Cox:2.2
> Marcelo Tosatti:2.4
> %
>
> Now, if I want to add something to the table, either I can use the
> relevenet userspace tools, but the following also will work.
>
> % echo 'Linus Torvalds:2.6' > maintainers

/etc/passwd

-- 
Måns Rullgård
mru@kth.se

