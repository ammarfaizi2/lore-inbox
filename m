Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUIMVW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUIMVW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUIMVW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:22:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54268 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268964AbUIMVW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:22:26 -0400
From: Christian Borntraeger <linux@borntraeger.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.9-rc2 : oops
Date: Mon, 13 Sep 2004 23:22:22 +0200
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       hch@infradead.org
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org> <Pine.LNX.4.58.0409131318320.2378@ppc970.osdl.org> <20040913140002.6e5fa076.akpm@osdl.org>
In-Reply-To: <20040913140002.6e5fa076.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409132322.22791.linux@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> There's a known double-free in the isofs filesystem.  Christian, were you
> using CDROMs at the time?

Yes I was - see my other mail. 

> Invalidate this pointer so it doesn't get freed twice.

Your patch fixes my problem. Thanks

Christian
