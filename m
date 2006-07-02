Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWGBVIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWGBVIM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 17:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGBVIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 17:08:12 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:34709 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750783AbWGBVIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 17:08:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DQlv/0OL2OAPKNedr3Gx7u6nAYNcsHAZ4eYyGLvdu0E10bvBcwFWUVOi8mRow0SHbG+Zq0CxMwkFwQkksXfbd2++6zpHVb2U0uA69A2bUTFEE319gJsRxsUmnupAGDRMiuqf4jnmGYKiSLV5JUHig1mXni59VXOeZUJNUjkO4vQ=
Message-ID: <20f65d530607021408w3d95853l1f74f2d2dbcd5486@mail.gmail.com>
Date: Mon, 3 Jul 2006 09:08:10 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: rwlock bad magic, spinlock recursion, spinlock lockup on CPU#0 &
In-Reply-To: <20f65d530606302250q79c485b9y8dfc4d032e4dc091@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530606302250q79c485b9y8dfc4d032e4dc091@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Previously, we were constantly getting hard freezes on kernel
> 2.6.14.2. After upgrading to 2.6.16.18, things were very stable (no
> crashes for days instead of hours). But today we managed to catch a
> hard freeze via serial console. Can anone help us track this one
> please?
>

It turns out that the RAM socket is not in contact with the RAM
securely (poorly designed hardware), we reinserted the RAM, and are
not experiencing freezes anymore.

Regards
Keith
