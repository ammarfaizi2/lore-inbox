Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVAXSqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVAXSqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVAXSqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:46:24 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:12191 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261564AbVAXSqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:46:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bApaNNKFWySD+iECAKXFMIjcOFUPR4tY4CuuHL6OY2VUnqI/Mu1U1jF0mCZo+XqyfErRX9IRcgMw9TRp5g1Vhoe+bOSkreBqwpz91yODDupA/YQVV65QcUq/MxntzOucfUMvHmpKWsAjyMGQGoKAfd3CKe/dVODGX/JAnGhrNEw=
Message-ID: <81b0412b05012410463c7fd842@mail.gmail.com>
Date: Mon, 24 Jan 2005 19:46:18 +0100
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Pavel Fedin <sonic_amiga@rambler.ru>
Subject: Re: [PATCH] Russian encoding support for MacHFS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050124125756.60c5ae01.sonic_amiga@rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124125756.60c5ae01.sonic_amiga@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(could you please use shorter lines? Around 80 is good. It's difficult to read).

On Mon, 24 Jan 2005 12:57:56 +0300, Pavel Fedin <sonic_amiga@rambler.ru> wrote:
> ... This means that you must to be able to reverse-translate all names from
> Linux encoding to Mac encoding. Using NLS causes characters loss if
> requested character does not exist in the table (it is substituted by '?').
> Macintosh disks often contains specific characters in file names
> ("Folder" character for example) which will be lost in this case.

how about just leave the characters unchanged? (remap them to the same
codes in Unicode).

> Probably using utf8 as host encoding would solve the problem but it's not
> commonly used in Russia.

Unicode, and its encoding UTF8 IS commonly used everywhere.
And Russia can (and often does) use it just as well.

P.S. Read Documentation/SubmittingPatches.
What kernel is the patch against?
