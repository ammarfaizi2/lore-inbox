Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVKGIyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVKGIyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVKGIyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:54:45 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:28203 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932460AbVKGIyo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:54:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PkDCpHFw4BYluU8CeB4SFXf8De8AeOwF40cbnR4NW5cHu9pR49GHPDBrKXNDqv5PdIYjjWixZSt64T0suAbcliNTl++haOlRFnjJAWtpuv+qB8pKff3JQAKCN74NHMtwb5F5WyuhpFGD0WZqdzIyf3KQpeRejPk5eyUC6rcePVo=
Message-ID: <1e62d1370511070054i113cd387y187a14a526d19eb7@mail.gmail.com>
Date: Mon, 7 Nov 2005 13:54:43 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: ext3crypt <ext3crypt@comcast.net>
Subject: Re: Am I thinking correctly?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <PFEILFFLMPNHAOBNBGPJGEHDCHAA.ext3crypt@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <PFEILFFLMPNHAOBNBGPJGEHDCHAA.ext3crypt@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, ext3crypt <ext3crypt@comcast.net> wrote:
> I'm working on a masters project for PSU.  It requires that I modify the
> ext3 and fs code in the kernel proper.
>
> The idea is to encrypt data just prior to it being written to disk.  I've
> created a new version of __block_write_full_page (which is called from
> writepage) to allocate a new (GFP_NOFS) page, setup the buffer_head list and
> copy the data to the new page (and encrypt it too).  When I do this, the
> data is not written to disk from the new buffer_head that I submit using
> submit_bh().  I've treked through this code and I'm convinced I'm down the
> right path.  Am I?  Any assistance would be appreciated.
>

Which kernel version you are using ?
Using kernel Encryption API ?
How you got to know that your data is not written to disk ? Getting
any error message ? or some-thing else ?
And a url or attachment of code will help others to get to your problem !


--
Fawad Lateef
