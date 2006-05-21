Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWEUTfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWEUTfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWEUTfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:35:46 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:38492 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964911AbWEUTfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:35:45 -0400
Date: Sun, 21 May 2006 12:35:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Dave Jones <davej@redhat.com>, dragoran <dragoran@feuerpokemon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521193542.GA1594@taniwha.stupidest.org>
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org> <20060521160332.GA8250@redhat.com> <a36005b50605211135v2d55827fr96360d9a025b9db8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50605211135v2d55827fr96360d9a025b9db8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 11:35:12AM -0700, Ulrich Drepper wrote:

> It's not a glibc problem really.  The problem is this stupid error
> message in the kernel.

It must have been added very recently surely?  Has this syscall
implemented and the FC kernel doesn't seem that old.

Did FC update glibc "ahead of it's kernel" in a sense?

> We rely in many dozens of places on the kernel returning ENOSYS in
> case a syscall is not implemented and we deal with it appropriately.

Is there a list or document anywhere which details what glibc's
requirements are when it comes to unimplemented syscalls and fallback
behavior?
