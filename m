Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbTJAIri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTJAIrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:47:37 -0400
Received: from tag.witbe.net ([81.88.96.48]:12050 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262046AbTJAIre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:47:34 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <andersen@codepoet.org>, "'Andreas Steinmetz'" <ast@domdv.de>
Cc: "'Jens Axboe'" <axboe@suse.de>,
       "'Joerg Schilling'" <schilling@fokus.fraunhofer.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel includefile bug not fixed after a year :-(
Date: Wed, 1 Oct 2003 10:47:17 +0200
Message-ID: <022801c387f8$9ef56f70$4300a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030930190039.GA5407@codepoet.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wrong.  Userland applications should make private copies of all
> needed kernel defines and structures, and then change any kernel
> types to use standard C99 types from stdint.h.

Disk are cheaper and cheaper !!!!

Please add to Makefile default behavior :

includes:
  cp -R /usr/src/linux/include/ .

all: includes ...

Paul

