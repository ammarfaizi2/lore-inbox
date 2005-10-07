Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVJGMQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVJGMQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVJGMQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:16:29 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:59149 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932396AbVJGMQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:16:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gQ0gTZcx7P2wu4VgAhvHD5vJ9/W9unfjwG84Dd8M4mbxHCdB67s3bceqgAa/CwqRL5qigT/5phXBuCgUDM9HRBgJrPNZjVOi8aTxb+/KrpAGQaxnjVeOPW74S/WOUTpqgitKEKkKxzz3MumUmpZRWFFkWDjGBLc8qjgvgAqhI+c=
Date: Fri, 7 Oct 2005 16:27:53 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andreas Herrmann <aherrman@de.ibm.com>
Subject: Re: [PATCH] gfp flags annotations - part 1
Message-ID: <20051007122753.GB27310@mipter.zuzino.mipt.ru>
References: <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <20051007025644.GA11132@kroah.com> <20051007064604.GB7992@ftp.linux.org.uk> <20051007100145.GA27310@mipter.zuzino.mipt.ru> <20051007100446.GA15122@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007100446.GA15122@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 12:04:46PM +0200, Heiko Carstens wrote:
> zfcp_mempool_alloc needs to fit the prototype of mempool_alloc_t.
> If you have a better idea to implement a mempool, please let us
> know. The calls you mention are actually calls to mempool_create
> and not to zfcp_mempool_alloc, or are you talking about
> something different?

Ouch. I'll shut up now.

