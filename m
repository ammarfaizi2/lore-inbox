Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTETMMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTETMMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:12:14 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:62527 "EHLO
	mwinf0103.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263750AbTETMMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:12:14 -0400
From: Duncan Sands <duncan.sands@wanadoo.fr>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
Date: Tue, 20 May 2003 14:25:07 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200305151917.h4FJHbGi014157@locutus.cmf.nrl.navy.mil>
In-Reply-To: <200305151917.h4FJHbGi014157@locutus.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305201425.07552.duncan.sands@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 May 2003 21:17, chas williams wrote:
> In message <20030515190922.GA10161@kroah.com>,Greg KH writes:
> >Thanks, didn't know they could be removed.  The speedtch author told me
> >a while ago that the fops didn't protect it...
>
> i cant see why it wouldn't but i really dont have the hardware to double
> check this statement.

I remember coming to the conclusion that the fops_get was not enough,
but I can no longer see why I thought that...  Greg has already applied
the patch to 2.5, I will send a patch for 2.4.

Ciao,

Duncan.
