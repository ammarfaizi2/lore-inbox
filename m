Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263673AbUEKVaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbUEKVaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUEKVaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:30:05 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:47626 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263665AbUEKV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:29:27 -0400
Subject: Re: 2.6.6 turns off HDD on reboot
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Dmitry Ivanov <dimss@solutions.lv>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040511202052.GA30241@new.solutions.lv>
References: <20040511202052.GA30241@new.solutions.lv>
Content-Type: text/plain
Message-Id: <1084310967.1684.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Tue, 11 May 2004 23:29:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 22:20, Dmitry Ivanov wrote:
> 2.6.6 turns off my HDD on reboot. After 2-3 secs
> BIOS turns it on again. All kernels before 2.6.6
> worked OK.

I think this is related to new IDE cache flush stuff.
Also, I think this behavior is not desirable and will cause HDD motors
to break faster due to the increased spin up/down cycles.

