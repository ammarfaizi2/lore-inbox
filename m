Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWDRCGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWDRCGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 22:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDRCGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 22:06:15 -0400
Received: from uproxy.gmail.com ([66.249.92.168]:4823 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932083AbWDRCGO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 22:06:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nRONsWyWmIAjS2x6RgKRkQ0vdl+ONqVRvtudE2h+i21BEKSyJkcHF+xBFQRjfQTyEkCKEqBe0ikv7+5pE4SIHSfJinnfR6yP20FPCBWZKJsS6zguUBbg3EfwzJ58s5Lea3tzSNMvxfMweEg0HR6oQGAxv/Unys3TRmqWGlO+PQI=
Message-ID: <625fc13d0604171906r27617e01jdf486977176a6a75@mail.gmail.com>
Date: Mon, 17 Apr 2006 21:06:13 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Thiago Galesi" <thiagogalesi@gmail.com>
Subject: Re: [PATCH] Remove unnecessary kmalloc/kfree calls in mtdchar
Cc: "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <82ecf08e0604170924y48deb5d1n1fdcfaaac9e257fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <82ecf08e0604141938w4b29259av797e3115b79042a0@mail.gmail.com>
	 <625fc13d0604170506n53147772vec944cdd7f2daef7@mail.gmail.com>
	 <82ecf08e0604170619i582bfa19r19a3da0d7d0904b1@mail.gmail.com>
	 <1145285434.13200.9.camel@pmac.infradead.org>
	 <82ecf08e0604170803u620c67e0nf98312bd90e1e14c@mail.gmail.com>
	 <1145290249.13200.17.camel@pmac.infradead.org>
	 <82ecf08e0604170924y48deb5d1n1fdcfaaac9e257fe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/06, Thiago Galesi <thiagogalesi@gmail.com> wrote:
> This patch removes repeated calls to kmalloc / kfree in mtd_write /
> mtd_read functions, replacing them by a single kmalloc / kfree pair.
>
> Signed-off-by: Thiago Galesi <thiagogalesi@gmail.com>

This version is in the MTD git tree now.  Thanks!

josh
