Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbTH0QRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbTH0QHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:07:41 -0400
Received: from dns10.mail.yahoo.co.jp ([210.81.151.143]:38035 "HELO
	dns10.mail.yahoo.co.jp") by vger.kernel.org with SMTP
	id S263610AbTH0QCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:02:51 -0400
X-Apparently-From: <yoshiyaeto@ybb.ne.jp>
Message-ID: <003101c36cb4$a785e930$0b01a8c0@CELERON>
From: "YoshiyaETO" <yoshiyaeto@ybb.ne.jp>
To: <linux-kernel@vger.kernel.org>
References: <000801c36cb1$454d4950$1001a8c0@etofmv650>
Subject: Re: cache limit
Date: Thu, 28 Aug 2003 01:02:45 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 27 Aug 2003 02:45:12 -0700, William Lee Irwin III wrote:
> >> How do you know it would be effective? Have you written a patch to
> >> limit it in some way and tried running it?
>
> On Wed, Aug 27, 2003 at 08:14:12PM +0900, Takao Indoh wrote:
> > It's just my guess. You mean that "index cache" is on the pagecache?
> > "index cache" is allocated in the user space by malloc,
> > so I think it is not on the pagecache.
>
> That will be in the pagecache.

    No. DBMS usually uses DIRECTIO that bypass the pagecache.
So, "index caches" in the DBMS user space will not be in pagecache.

