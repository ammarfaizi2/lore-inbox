Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWDREhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWDREhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 00:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDREhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 00:37:31 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:46279 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932173AbWDREha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 00:37:30 -0400
Message-ID: <00d701c662a1$cbace440$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, <linux-kernel@vger.kernel.org>,
       <Ext2-devel@lists.sourceforge.net>
References: <20060413161227sho@rifu.tnes.nec.co.jp> <20060413162028.GA23452@thunk.org> <020501c6621a$bf158c50$4168010a@bsd.tnes.nec.co.jp> <20060417124807.GB7429@stusta.de>
Subject: Re: [Ext2-devel] [RFC][15/21]e2fsprogs modify variables for bitmap to exceed 2G
Date: Tue, 18 Apr 2006 13:37:22 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your info, Adrian.

>> Though I checked if there are any commands which use the following
>> functions in RHEL4, no such commands were found except in e2fsprogs
>> itself.
>>...
>> ext2fs_test_block_bitmap()
>>...
> 
> Used by e2undel [1].

The function is certainly used in this command.  Then I'll consider
adding new functions which use blk64_t.

Cheers, sho
