Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbTDUMLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTDUMLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:11:33 -0400
Received: from [24.206.178.254] ([24.206.178.254]:29582 "EHLO brianandsara.net")
	by vger.kernel.org with ESMTP id S263829AbTDUMLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:11:31 -0400
From: Brian Jackson <brian@mdrx.com>
To: linux-kernel@vger.kernel.org
Subject: Re: sooner 2.4.21-pre8
Date: Mon, 21 Apr 2003 07:24:32 -0500
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.55.0304210823230.944@boston.corp.fedex.com> <200304202352.06128.brian@mdrx.com> <20030421010743.5309f585.arashi@yomerashi.yi.org>
In-Reply-To: <20030421010743.5309f585.arashi@yomerashi.yi.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304210724.32437.brian@mdrx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I meant the -bkN snapshots, but I can only seem to find them for Linus' tree. 
So if we want to use the cvs repository, we need to 

$ cvs rdiff -u -D 11/28/2002 -D now linux-2.4

(I show 11-28 for 2.4.20's release, at least that's when he sent the email)

seems easy enough.

--Brian Jackson

On Monday 21 April 2003 01:07 am, Matt Reppert wrote:
> On Sun, 20 Apr 2003 23:52:05 -0500
>
> Brian Jackson <brian@mdrx.com> wrote:
> > Isn't there a place to get frequent bk snapshots, or is that only Linus'
> > tree?
>
> export CVSROOT=:pserver:anonymous@kernel.bkbits.net:/home/cvs
>
> And you now have read access to up-to-date CVS "mirrors" of whatever's in
> bk. The module names are 'linux-2.4' and 'linux-2.5'.
>
> Matt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

