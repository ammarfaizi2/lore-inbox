Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbRGJJq3>; Tue, 10 Jul 2001 05:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbRGJJqU>; Tue, 10 Jul 2001 05:46:20 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:21295 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264717AbRGJJqB>; Tue, 10 Jul 2001 05:46:01 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200107100945.f6A9jte04637@devserv.devel.redhat.com>
Subject: Re: [PATCH]  IDE configurable max failures
To: thockin@sun.com (Tim Hockin)
Date: Tue, 10 Jul 2001 05:45:55 -0400 (EDT)
Cc: andre@linux-ide.org, alan@redhat.com,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B4AA8EB.D1F6947C@sun.com> from "Tim Hockin" at Jul 10, 2001 12:04:11 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached is a small patch to add a configurable maximum failure count for
> IDE drives.  It has been very useful for us.

It doesnt do what you think or want I suspect

> Please let me know if there is any reason this can not be included in the
> mainline kernel.

Linus please dont apply this one. A correct ide retry patch is pending
merging from -ac. One that properly resets the ide state machines and 
requeues the I/O


