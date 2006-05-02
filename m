Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWEBGqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWEBGqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWEBGqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:46:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:41175 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932406AbWEBGqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:46:11 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Avoid overwriting the current pgd (x86_64)
References: <20060501095407.16902.78809.sendpatchset@cherry.local>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2006 08:45:59 +0200
In-Reply-To: <20060501095407.16902.78809.sendpatchset@cherry.local>
Message-ID: <p73ejzc7wm0.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> --===============82697867595349228==
> 
> kexec: Avoid overwriting the current pgd (x86_64)
> 
> This patch upgrades the x86_64-specific kexec code to avoid overwriting the
> current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
> to start a secondary kernel that dumps the memory of the previous kernel.

Why is it bad?

-Andi
