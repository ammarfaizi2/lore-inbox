Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbTLQXWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTLQXWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:22:13 -0500
Received: from zero.aec.at ([193.170.194.10]:49157 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264604AbTLQXWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:22:12 -0500
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
From: Andi Kleen <ak@muc.de>
Date: Thu, 18 Dec 2003 00:22:02 +0100
In-Reply-To: <13SY1-35z-19@gated-at.bofh.it> (Alan Cox's message of "Thu, 18
 Dec 2003 00:10:17 +0100")
Message-ID: <m3hdzzni79.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <130kQ-3A0-13@gated-at.bofh.it> <130Xy-4Ia-3@gated-at.bofh.it>
	<131Ac-5Qy-3@gated-at.bofh.it> <137cD-8eg-9@gated-at.bofh.it>
	<13kD2-1kF-11@gated-at.bofh.it> <13qIi-31G-1@gated-at.bofh.it>
	<13DvZ-2RY-9@gated-at.bofh.it> <13DFw-3a8-9@gated-at.bofh.it>
	<13DPq-3s4-7@gated-at.bofh.it> <13Fem-6iy-7@gated-at.bofh.it>
	<13SY1-35z-19@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:
>
> And X11 will want to access it via /proc interfaces. And someone will eventually
> go and design a different way to access PCI-EX for their hardware 8)

It would be nice if it did. Just currently it uses racy port accesses
from user space :-(

-Andi
