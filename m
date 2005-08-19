Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVHSSD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVHSSD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVHSSD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:03:27 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:121 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965048AbVHSSD1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H290EpkVt/FCnKPNfxnDo5TsxLSEFNyDOCsE6ZNrNXspwab52PhlhZ3bNAH2Rp6C34Sz6lKIg8kHZ2zM31EcNQ0GiGu865a6/KlTWkNtAIRCaXKKDXK7WadaVeXQRDBfRNITwpOvbmdXpewvRcLVd8ZpY7Hx/UcBu5qCuQmwK24=
Message-ID: <9a87484905081911036dcedf57@mail.gmail.com>
Date: Fri, 19 Aug 2005 20:03:26 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc6-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> 

menuconfig complains a little :

$ make menuconfig
scripts/kconfig/mconf arch/i386/Kconfig
drivers/char/Kconfig:847:warning: 'select' used by config symbol
'TANBAC_TB0219' refer to undefined symbol 'PCI_VR41XX'

otherwise things seem to be ok here.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
