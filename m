Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUBTGiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267608AbUBTGh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:37:59 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:12026 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S267789AbUBTGgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:36:37 -0500
Message-ID: <4035AAC7.70701@iitbombay.org>
Date: Fri, 20 Feb 2004 12:05:51 +0530
From: Niraj Kumar <niraj17@iitbombay.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6]  UFS2 Read Only Patch
References: <40332F42.9070605@iitbombay.org> <20040218014422.7a1144b3.akpm@osdl.org>
In-Reply-To: <20040218014422.7a1144b3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I have updated the patch files.

Let me know if you have any more comments.

Niraj

Andrew Morton wrote:

>Niraj Kumar <niraj17@iitbombay.org> wrote:
>  
>
>The patches which you have there are a bit of a disaster coding-style wise.
>
>- Use hard tabs everywhere, not eight-spaces.
>
>- No space before terminating semicolons
>
>-
>
>+        if ( (flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
>+        {
>+	     uspi->s_u2_size  = fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size);
>
>  should be
>
>	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
>
>  etcetera.   See Documentation/CodingStyle.
>
>
>Thanks.
>  
>


