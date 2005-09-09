Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVIII5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVIII5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVIII5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:57:25 -0400
Received: from mail.suse.de ([195.135.220.2]:8848 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965100AbVIII5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:57:24 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Date: Fri, 9 Sep 2005 10:54:11 +0200
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43207D28020000780002451E@emea1-mh.id2.novell.com>
In-Reply-To: <43207D28020000780002451E@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091054.11932.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:04, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
>
> Allow building the x86-64 kernels with frame pointers if so needed.

This doesn't work because you would need to pass -fno-omit-frame-pointer
somewhere. Also I don't see much sense because all the assembly code
will break the frame chains.

-Andi

