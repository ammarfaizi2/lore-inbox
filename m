Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267392AbTGHOHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbTGHOHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:07:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60331
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267365AbTGHOFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:05:47 -0400
Subject: RE: [PATCH] path_lookup for 2.4.20-pre4 (ChangeSet@1.587.10.71)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trond.myklebust@fys.uio.no
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <16138.53118.777914.828030@charged.uio.no>
References: <16138.53118.777914.828030@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 15:16:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 15:04, Trond Myklebust wrote:
> This patch breaks NFS close-to-open cache consistency as it undoes
> those changes that provide path revalidation for the case of
> open(".").
> The changelog entry doesn't even attempt to document this removal...

I was a little suprised it went in, it never seemed a candidate for
dealing with a stable tree, just optimisation stuff that is 2.5 material
only

