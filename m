Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUDNT34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUDNT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:29:56 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:12679 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S261340AbUDNT3y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:29:54 -0400
Date: Wed, 14 Apr 2004 21:29:51 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Guillaume =?iso-8859-15?q?Lac=F4te?= <Guillaume@Lacote.name>
cc: linux-kernel@vger.kernel.org
Subject: Re: Using compression before encryption in device-mapper
In-Reply-To: <200404141725.31660.Guillaume@Lacote.name>
Message-ID: <Pine.LNX.4.58.0404142122050.1541@neptune.local>
References: <1KykU-4VD-17@gated-at.bofh.it> <1KTfJ-5gK-25@gated-at.bofh.it>
 <E1BDluf-00007s-PB@localhost> <200404141725.31660.Guillaume@Lacote.name>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Guillaume [iso-8859-15] Lacôte wrote:

> You are right that in this very case, the per-bit entropy will be
> (1 - 1/(1+1/8) ) ~ 12% lower than in the original text. The point is
> that this case (which has nothing to do with the case where a text can
> be well compressed or not, this is the worst _relative_ performance of
> dynamic versus static encoding) does not happen "too often".

I was only pointing out a corner case where your argument doesn't
hold. I completely agree that it is rather unlikely to happen with
real world data.

There is one exception, though: data that has already been compressed
before on a higher level; by the user, for example. However, in
that case you could say that what you're trying to accomplish has already
happened before during the original compression run.

-- 
Ciao,
Pascal
