Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbTFCOwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTFCOwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:52:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15085
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264767AbTFCOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:52:53 -0400
Subject: Re: software suspend in 2.5.70-mm3.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hugang <hugang@soulinfo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030603223511.155ea2cc.hugang@soulinfo.com>
References: <20030603211156.726366e7.hugang@soulinfo.com>
	 <1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk>
	 <20030603223511.155ea2cc.hugang@soulinfo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054649308.9233.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 15:08:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 15:35, hugang wrote:
> > The only way to make the suspend work properly is to queue the suspend
> > sequence wit the other requests. Ben was doing some playing with this
> > but I'm not sure what happened to it.
> > 
> Yes the above patch is not safe, When i'm run updatedb and suspsned, After resume will oops at kjournal. 
> 
> Here is another test on it, it can works with updatedb.

Still races. Ben's stuff is needed

