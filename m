Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269201AbTGJLIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269205AbTGJLIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:08:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58036
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269201AbTGJLIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:08:14 -0400
Subject: Re: RFC:  what's in a stable series?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20030710085338.C28672@infradead.org>
References: <3F0CBC08.1060201@pobox.com>
	 <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva>
	 <20030710085338.C28672@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 12:19:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 08:53, Christoph Hellwig wrote:
> Also the quota patches don't change any ABI or API - userland can still
> use the old ABI in addition to the new one, 16bit ondisk quotas are
> still supported and filesystems couldn't care less which implementation
> it plugs into - the API is the same.

Because you hacked v1 support out of Jan Kara's stuff the quota bits are
pretty useless to most people because they have v1 format files.

