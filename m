Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbUK2XSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbUK2XSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUK2XQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:16:36 -0500
Received: from www.zeroc.com ([63.251.146.250]:30856 "EHLO www.zeroc.com")
	by vger.kernel.org with ESMTP id S261881AbUK2XO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:14:26 -0500
Message-ID: <002c01c4d669$28ec6e30$6401a8c0@centrino>
From: "Bernard Normier" <bernard@zeroc.com>
To: <jonathan@jonmasters.org>
Cc: <linux-kernel@vger.kernel.org>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <35fb2e5904112914476df48518@mail.gmail.com>
Subject: Re: Concurrent access to /dev/urandom
Date: Mon, 29 Nov 2004 18:14:20 -0500
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

>> I use /dev/urandom to generate UUIDs by reading 16 random bytes from
>> /dev/urandom (very much like e2fsprogs' libuuid).
>
> Why not use /dev/random for such data instead?

A UUID generator that blocks from time to time waiting for entropy would not 
be usable.

Cheers,
Bernard

