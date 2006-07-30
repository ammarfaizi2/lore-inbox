Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWG3TG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWG3TG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWG3TG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:06:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:44476 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932440AbWG3TG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:06:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NLTxbXz+lmDlr0zr8LjpEIjnpmLS9yioDVXSJLeGTKLNNwh0e1hLoFWwGCnWjgmRdxsuU5sC9dvtOO2QnFezXOr4FJJv3dyI62zHXDw0U4VxMQ3d8aTNpSCfCivZPUVnlxznq1E5opQG6GfGQoZdFBavNp/HowPsuEY48v4pXwE=
Message-ID: <625fc13d0607301206h51694fe1n574efe1c61103b54@mail.gmail.com>
Date: Sun, 30 Jul 2006 14:06:55 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: RFC: remove include/mtd/jffs2-user.h
Cc: "David Woodhouse" <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060723190239.GB25367@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060723190239.GB25367@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/06, Adrian Bunk <bunk@stusta.de> wrote:
> include/mtd/jffs2-user.h is not used in the kernel, and depends on
> user space providing a variable target_endian.
>
> I don't see it providing an interface between the kernel and user space.
>
> It seems this header should be part of the user space MTD tools instead
> of headers provided by the kernel?

The mtd-utils already has a copy of this file.  I don't see a reason
for it to stay in kernel.

josh
