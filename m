Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWJ2BUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWJ2BUo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 21:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWJ2BUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 21:20:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:58695 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932117AbWJ2BUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 21:20:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d4C7/LDa7aZ1ZC3famCv4mcuDRgE/7Je4Nfw42G8YYfQL5IfiR5v1Xxs5JAM89t2TXW7T47V6HUiPTKZ4ITy6nFpbWv6wSKOLJy/+IBtH4GTqFU0QLttwQkzW+zFHuyIpDN7aK+cbDOWrJ1wiCJ3k1LznyOLNVckP/I5ap/IMUY=
Message-ID: <b6a2187b0610281820k95f57f9t5e0a4be0e30845d4@mail.gmail.com>
Date: Sun, 29 Oct 2006 09:20:42 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: linux-2.6.19-rc2 PCI problem
Cc: "Adrian Bunk" <bunk@stusta.de>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, "David Miller" <davem@davemloft.net>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Yinghai Lu" <yinghai.lu@amd.com>
In-Reply-To: <20061028154534.GR5591@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
	 <20061025013022.GG27968@stusta.de>
	 <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
	 <20061026152455.GI27968@stusta.de>
	 <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com>
	 <20061027203109.GZ27968@stusta.de>
	 <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com>
	 <20061028032024.GD27968@stusta.de>
	 <b6a2187b0610280324s66b06067od4691fa9f79420a7@mail.gmail.com>
	 <20061028154534.GR5591@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/06, Matthew Wilcox <matthew@wil.cx> wrote:

> BIOS isn't a great option to choose ... how does Direct work out for
> you?
>
> I suspect you're having problems with the MMConfig method; confirming
> that would be a good step towards debugging the problem.

Matthew,

Ok, just tried DIRECT, and it works.


Thanks,
Jeff.
