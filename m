Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUA0SY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUA0SY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:24:58 -0500
Received: from ns.suse.de ([195.135.220.2]:33167 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265221AbUA0SY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:24:57 -0500
To: dada1 <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.1 x86_64 : STACK_TOP and text/data
References: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com.suse.lists.linux.kernel>
	<40162E9A.1080005@cosmosbay.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Jan 2004 19:24:55 +0100
In-Reply-To: <40162E9A.1080005@cosmosbay.com.suse.lists.linux.kernel>
Message-ID: <p73k73dfdvs.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dada1 <dada1@cosmosbay.com> writes:

> Anybody knows why STACK_TOP is defined to 0xc0000000 in x86_64 ?

STACK_TOP is only for 32bit a.out executables running on x86-64
ELF 32bit and 64bit programs use different defaults.

-Andi
