Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTESVBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTESVBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:01:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61192 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262872AbTESVBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:01:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Recent changes to sysctl.h breaks glibc
Date: 19 May 2003 14:14:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <babheo$s9r$1@cesium.transmeta.com>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519105152.GD8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030519105152.GD8978@holomorphy.com>
By author:    William Lee Irwin III <wli@holomorphy.com>
In newsgroup: linux.dev.kernel
> 
> IIRC you're supposed to use some sort of sanitized copy, not the things
> directly. IMHO the current state of affairs sucks as there is no
> standard set of ABI headers, but grabbing them right out of the kernel
> is definitely not the way to go.
> 

This "cure" sucks worse than the disease.  Now you're putting it onto
everyone who maintains userspace to do the same repetitive task of
"sanitizing" this.  Especially for things this trivial, this is a
ridiculous concept.

For 2.7, getting real exportable ABI headers is so bloody necessary
it's not even funny.  However, for 2.5, breaking things randomly is
not the way to go.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
