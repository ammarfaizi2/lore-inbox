Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269037AbUIMWte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269037AbUIMWte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUIMWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:48:29 -0400
Received: from mail03.powweb.com ([66.152.97.36]:62730 "EHLO mail03.powweb.com")
	by vger.kernel.org with ESMTP id S269034AbUIMWr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:47:59 -0400
From: "David Dabbs" <david@dabbs.net>
To: "'ReiserFS List'" <reiserfs-list@namesys.com>,
       <linux-kernel@vger.kernel.org>
Cc: <viro@parcelfarce.linux.theplanet.co.uk>
Subject: RE: Re: [PATCH] use S_ISDIR() in link_path_walk() to decide whether the last path component is a directory
Date: Mon, 13 Sep 2004 17:47:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSZ2Wr/B6Nedt+kRzGeuLC3soNW6QACF4lQ
Message-Id: <20040913224757.B2EAC15C76@mail03.powweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> viro wrote:
>>     if (*name == '/') {
>>        if (*(name+1)=='/' && *(name+2)==':') {
>>           name+=3;
>
>	Pathname resolution is a hell of a fundamental thing and kludges
>like that are too ugly to be acceptable.  If you can't make that clean
>and have to resort to stuffing "special cases" (read: barfbag of ioctl
>magnitude) into the areas that might be unspecified by POSIX, don't do it
>at all.
>

Even though SuS allows for implementation-specific resolution for pathnames
starting with "//"? It's kludgy, and I suspected that might be the response,
but I thought I'd float it nonetheless.

>I don't like the amount of handwaving from Hans, but *that* is far
>worse.  Vetoed.

Kludgy, yes, but far worse?  At least I bothered to take the SuS into
consideration and took the time to try an approach, however kludgy, that
might work within them. 

Bilious or not, thanks for the feedback.


david


