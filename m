Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVITTdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVITTdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVITTdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:33:08 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:12489 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965093AbVITTdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:33:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LO3UgYoCw35eryCfx2mb1Sh7nm5xIx6DH52hGgQ4axQZaDKfqdwnjR4nYK8CLCVez0Wjgn8FINUqZ4co0HpaBAyb+s1ZZ/p9X2uRkiAX0bJyjpMLnRl2JuuLFuolxE0tT/RngBv0pivjE0Zf7ocRWlKiILyAwBmaoVLQ9wrbKNM=
Date: Tue, 20 Sep 2005 23:43:36 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 Slab corruption during boot
Message-ID: <20050920194336.GB3858@mipter.zuzino.mipt.ru>
References: <20050916141445.GA32693@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916141445.GA32693@janus>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 04:14:45PM +0200, Frank van Maarseveen wrote:
> stock 2.6.13.1 on a P4 with HT:

> Sep 16 16:02:01 espoo kernel: Slab corruption: start=f7f31000, len=4096
> Sep 16 16:02:01 espoo kernel: 0b0: 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff 00 00 00 00

I've filed a bug at kernel bugzilla so your report won't be lost. See
http://bugme.osdl.org/show_bug.cgi?id=5278

Please, register at http://bugme.osdl.org/createaccount.cgi and add
yourself to CC list.

