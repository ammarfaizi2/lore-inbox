Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUF0TSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUF0TSk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUF0TSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:18:40 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:65029 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261914AbUF0TRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:17:18 -0400
Subject: Re: [PATCH] Staircase scheduler v7.4
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: kernel@kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
In-Reply-To: <200406261929.35950.mbuesch@freenet.de>
References: <200406251840.46577.mbuesch@freenet.de>
	 <200406252148.37606.mbuesch@freenet.de>
	 <1088212304.40dccd5035660@vds.kolivas.org>
	 <200406261929.35950.mbuesch@freenet.de>
Content-Type: text/plain
Date: Sun, 27 Jun 2004 21:17:01 +0200
Message-Id: <1088363821.1698.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 19:29 +0200, Michael Buesch wrote:

> Now another "problem":
> Maybe it's because I'm tired, but it seems like
> your fix-patch made moving windows in X11 is less smooth.
> I wanted to mention it, just in case there's some other
> person, who sees this behaviour, too. In case I'm the
> only one seeing it, you may forget it. ;)

I can see the same with 7.4-1 (that's 2.6.7-ck2 plus the fix-patch): X11
feels sluggish while moving windows around. Simply by loading a Web page
into Konqueror and dragging Evolution over it, makes me able to
reproduce this problem.

Doing the same on 2.6.7-mm3 is totally smooth, however.

