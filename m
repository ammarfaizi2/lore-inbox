Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVAEImW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVAEImW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 03:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVAEImW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 03:42:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:16530 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262295AbVAEImR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 03:42:17 -0500
Date: Wed, 5 Jan 2005 00:42:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-Id: <20050105004202.3de71167.akpm@osdl.org>
In-Reply-To: <crd864$bkp$1@sea.gmane.org>
References: <20050102221534.GG4183@stusta.de>
	<41D87A64.1070207@tmr.com>
	<20050103003011.GP29332@holomorphy.com>
	<20050103004551.GK4183@stusta.de>
	<20050103011935.GQ29332@holomorphy.com>
	<20050103053304.GA7048@alpha.home.local>
	<20050103123325.GV29332@holomorphy.com>
	<20050103213845.GA18010@alpha.home.local>
	<crd864$bkp$1@sea.gmane.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
>
> With linux-2.4, I could click on such folder and the
>  list of messages sorted by subject will appear in KMail almost instantly.
>  With linux-2.6, this process takes much longer.

There was a bug in kmail which caused this.  It must have been a quite old
version.  It can be worked around by mounting the reiserfs3 filessytem with
the "nolargeio=1" mount option.  Or by upgrading kmail.

