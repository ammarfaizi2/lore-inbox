Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbULNWq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbULNWq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbULNWop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:44:45 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:6621 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261716AbULNWoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:44:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JAxYqfMoeHmQGvlUvSa+EETyy1kfSYv8q/Ngilf1euMXbftr20ZPTcHE7mIZPh8h+XEGvZFTveWtEXzIXW0BpXVzqWqNMFZMfzRwamHVnj5r4UFc0D9J9lQ0zZbJlO6j1qkpieMpwQ6ShEBiMtZG9q6QlkV85mAmWOW1syc7tPM=
Message-ID: <a36005b50412141444432cb6c1@mail.gmail.com>
Date: Tue, 14 Dec 2004 14:44:17 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX clock_* syscalls
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <p73zn0gzojo.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412140355.iBE3t7KL008040@magilla.sf.frob.com.suse.lists.linux.kernel>
	 <p73zn0gzojo.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Dec 2004 20:07:39 +0100, Andi Kleen <ak@suse.de> wrote:

> I don't think this should be merged until a clear need from a useful
> application is demonstrated for it.

This is something which is requested countless times.  Everybody doing
development of sophisticated programs adds some kind of self
monitoring.  And there is of course profiling.  The most widely used
program which needs this is probably the JVM.  Don't ask me for the
specific class, but the JVM developers asked for these clocks in this
form.  Without the support available the Linux JVM is never going to
reach par.
