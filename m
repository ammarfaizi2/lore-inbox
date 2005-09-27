Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVI0L6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVI0L6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 07:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVI0L6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 07:58:03 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:13489 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964906AbVI0L6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 07:58:01 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: =?ISO-8859-1?Q?=20Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Date: Tue, 27 Sep 2005 21:57:52 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com>
References: <20050927111038.GA22172@ime.usp.br>
In-Reply-To: <20050927111038.GA22172@ime.usp.br>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 08:10:39 -0300, Rogério Brito <rbrito@ime.usp.br> wrote:

>Hi there. I'm seeing a really strange problem on my system lately and I
>am not really sure that it has anything to do with the kernels.

Probably not, I had a similar problem recently and for a test case 
copied a .iso image file then compared it to original (cp + cmp), 
turned out to be bad memory, and yes, memtest86 did not find the 
problem.  Check mobo datasheet if 2+ double-sided memory allowed, 
you may need to stay at 1GB to reduce bus loading.

Cheers,
Grant.

