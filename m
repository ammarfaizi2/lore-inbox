Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTKVXHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTKVXHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 18:07:05 -0500
Received: from ns.suse.de ([195.135.220.2]:5797 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262817AbTKVXHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 18:07:03 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>, Timothy Miller <miller@techsource.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       Justin Cormack <justin@street-vision.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby>
	<20031120172143.GA7390@deneb.enyo.de> <03112013081700.27566@tabby>
	<1069357453.26642.93.camel@lotte.street-vision.com>
	<3FBD27A0.50803@techsource.com>
	<20031120140739.I20568@schatzie.adilger.int>
	<3FBD328C.1070607@techsource.com> <20031122145031.GA189@elf.ucw.cz>
	<20031122195052.GA17077@mail.shareable.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: How many retired bricklayers from FLORIDA are out purchasing
 PENCIL SHARPENERS right NOW??
Date: Sun, 23 Nov 2003 00:07:00 +0100
In-Reply-To: <20031122195052.GA17077@mail.shareable.org> (Jamie Lokier's
 message of "Sat, 22 Nov 2003 19:50:52 +0000")
Message-ID: <jeoev4ngtn.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Pavel Machek wrote:
>> > It is, though.  If you run out of space copying a file, you know it when 
>> > you're copying.  Applications don't usually expect to get out-of-space 
>> > errors while overwriting something in the middle of a file.
>> 
>> Same can happen on compressed filesystem...
>
> Or a filesystem with snapshots, e.g. using LVM.

Or writing to a sparse file.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
