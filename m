Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUKSFGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUKSFGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 00:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUKSFGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 00:06:12 -0500
Received: from hera.kernel.org ([63.209.29.2]:31947 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261256AbUKSFGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 00:06:01 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: PATCH: Altivec support for RAID-6
Date: Fri, 19 Nov 2004 05:05:54 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cnjuvi$um8$1@terminus.zytor.com>
References: <419C46C7.4080206@zytor.com> <69304d1104111812234656a606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1100840754 31433 127.0.0.1 (19 Nov 2004 05:05:54 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 19 Nov 2004 05:05:54 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <69304d1104111812234656a606@mail.gmail.com>
By author:    Antonio Vargas <windenntw@gmail.com>
In newsgroup: linux.dev.kernel
> 
> hpa, are you aware of any other routines which should benefit from altivec?
> 

Presumably the XOR code used by RAID-5, and quite possibly some of the
cryptography stuff.  Unlike most SIMD instruction sets, it should be
possible to write AES using Altivec.

	-hpa
