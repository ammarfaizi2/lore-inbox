Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTIRC2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 22:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTIRC2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 22:28:20 -0400
Received: from [208.191.98.137] ([208.191.98.137]:24448 "EHLO xorgate.com")
	by vger.kernel.org with ESMTP id S262927AbTIRC2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 22:28:19 -0400
Message-ID: <001a01c37d94$e13032d0$3eac18ac@geosxp>
From: "George" <george@xorgate.com>
To: "Oleg Drokin" <green@namesys.com>, "Hans Reiser" <reiser@namesys.com>
Cc: <linux-kernel@vger.kernel.org>
References: <000501c37a0c$e2ad24a0$3eac18ac@geosxp> <3F63E898.4010803@namesys.com> <20030914084141.GA28617@namesys.com>
Subject: Re: 2.6 kernel large file create problem
Date: Wed, 17 Sep 2003 21:28:06 -0600
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

From: "Oleg Drokin" <green@namesys.com>
> Indeed.
> Try this patch, it should help.
> Tell us if you experience any problems with the patch.
>

I have been off into the LVM2 muttle puddle, between kernels 2.4.22 and
2.6.0-t5. . .

If I do not include LVM2 below reiserfs then, yes, the 2.6.0 reiserfs file.c
patch you provided works (for files larger than 4GB).  Thanks!

However, if I include LVM2 on the 2.6.0-t5 kernel and place a reiserfs on
top of LVM2 logical volume, I get "Input/output errors" from diff commands
for files >2GB.

Again if I use a similar file system config. using the 2.4.22 kernel
everything works fine.  More on this latter.  ( I may  missing
omething  ->[more research].)

