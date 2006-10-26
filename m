Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWJZBC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWJZBC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 21:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbWJZBC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 21:02:27 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:33257 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S965254AbWJZBCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 21:02:25 -0400
Date: Wed, 25 Oct 2006 21:02:00 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Holden Karau <holden@pigscanfly.ca>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       holdenk@xandros.com, "akpm@osdl.org" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes in fat_mirror_bhs
Message-ID: <20061026010200.GE7128@filer.fsl.cs.sunysb.edu>
References: <f46018bb0610251652y7b29889cr8a41044db6168432@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f46018bb0610251652y7b29889cr8a41044db6168432@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 07:52:47PM -0400, Holden Karau wrote:
...
> And now for the actual patch:
> --- a/fs/fat/fatent.c	2006-09-19 23:42:06.000000000 -0400
> +++ b/fs/fat/fatent.c	2006-10-25 19:14:14.000000000 -0400
> @@ -1,5 +1,6 @@
> /*
>  * Copyright (C) 2004, OGAWA Hirofumi
> + * Copyright (C) 2006, Holden Karau [Xandros]
>  * Released under GPL v2.
>  */

Mangled up :)

Josef "Jeff" Sipek.

-- 
Only two things are infinite, the universe and human stupidity, and I'm not
sure about the former.
		- Albert Einstein
