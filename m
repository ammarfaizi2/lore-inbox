Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTJAItb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTJAIs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:48:57 -0400
Received: from tag.witbe.net ([81.88.96.48]:15890 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262053AbTJAIsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:48:54 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <andersen@codepoet.org>, "'Jens Axboe'" <axboe@suse.de>
Cc: "'David S. Miller'" <davem@redhat.com>,
       "'Andreas Steinmetz'" <ast@domdv.de>, <schilling@fokus.fraunhofer.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel includefile bug not fixed after a year :-(
Date: Wed, 1 Oct 2003 10:48:45 +0200
Message-ID: <022901c387f8$d35c3320$4300a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030930190908.GC5407@codepoet.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> A classic recent example is iproute, which uses kernel headers
> all over the place.  It compiled with earlier 2.4.x kernels, but
> it no longer compiles 2.4.22.  I've not bothered to try and fix
> it, but if it included its own set of sanitized kernel headers,
> it would not have had a problem.

And if some IOCTLs were changed in between, in the kernel and
kernel headers ? 
You end up with an application that you can compile, but doesn't
behave as expected ? What a progress :-(

Regards,
Paul

 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BASIC programmers never die, they GOSUB and don't RETURN.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


