Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWJCQ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWJCQ26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWJCQ26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:28:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48285 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750921AbWJCQ25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:28:57 -0400
Message-ID: <45228F83.1000309@sandeen.net>
Date: Tue, 03 Oct 2006 11:27:47 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
References: <451C33B2.5000007@goop.org> <20060928142313.8848cec9.akpm@osdl.org> <4521F5DE.7070302@sandeen.net> <20061003054242.GK3278@stusta.de> <45226E4D.8020302@sandeen.net> <20061003162313.GA7398@stusta.de>
In-Reply-To: <20061003162313.GA7398@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> Another tainted kernel...

Yes.  One was tainted with a force, and another tainted with proprietary
modules.

I was quick to dismiss the first one due to the taint, but the
likelihood of both taints being the root cause of the exact same
corruption seems low.  Still, nigh impossible to work with.

-Eric
