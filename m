Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTIJKV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbTIJKV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:21:26 -0400
Received: from mid-1.inet.it ([213.92.5.18]:56503 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S261334AbTIJKVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:21:25 -0400
Message-ID: <024601c37785$e3e07680$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <01c601c3777f$97c92680$5aaf7450@wssupremo> <20030910114414.B14352@devserv.devel.redhat.com> <01f801c37783$9ead8960$5aaf7450@wssupremo> <20030910121453.B9878@devserv.devel.redhat.com>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 12:25:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm saying it can. I don't want to go too deep into an arguement about
> microarchitectural details, but my point was that a memory copy of a page
> is NOT super expensive relative to several other effects that have to do
> with pagetable manipulations.

Sorry, but I cannot believe it.
Reading a page tagle entry and storing in into a struct capability is not
comparable at all with the "for" needed to move bytes all around memory.

> but the pipe code cannot know this so it has to do a cross cpu invalidate.

Sorry for you. Don't knowning does not justify it.
It's inefficient.

> and... which is also releasing it before the copy

Oh, yes. After wasting thousands of cycles, sure.

Bye,
Luca.

