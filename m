Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTKVRM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTKVRM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:12:57 -0500
Received: from gprs147-100.eurotel.cz ([160.218.147.100]:63104 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262432AbTKVRM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:12:56 -0500
Date: Sat, 22 Nov 2003 15:50:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Timothy Miller <miller@techsource.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Justin Cormack <justin@street-vision.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031122145031.GA189@elf.ucw.cz>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby> <20031120172143.GA7390@deneb.enyo.de> <03112013081700.27566@tabby> <1069357453.26642.93.camel@lotte.street-vision.com> <3FBD27A0.50803@techsource.com> <20031120140739.I20568@schatzie.adilger.int> <3FBD328C.1070607@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBD328C.1070607@techsource.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>This could be a problem if COW causes you to run out of space when 
> >>writing to the file.
> >
> >
> >Not much different than running out of space copying a file.
> 
> It is, though.  If you run out of space copying a file, you know it when 
> you're copying.  Applications don't usually expect to get out-of-space 
> errors while overwriting something in the middle of a file.

Same can happen on compressed filesystem...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
