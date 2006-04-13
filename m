Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWDMPBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWDMPBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWDMPBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:01:06 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:4969 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750838AbWDMPBF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:01:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c8IPfZDQ6S6Pdxt814CsZzDoXzgb4VOQhjx80MegGv300bu6KBVPzqCeJLV8EDRusURpubmGGA+zVPzy/5hrVBlxXEvP6xJ0uSMYvyug8QImuPbzhqN29SJ4RNI8vMBUb6mvcMHliakKrWJ9mQfimHORfUUFbu6w1tNoRaL9lx8=
Message-ID: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
Date: Thu, 13 Apr 2006 10:01:04 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "linux mailing-list" <linux-kernel@vger.kernel.org>
Subject: select takes too much time
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using select with a timeout value of 90 ms. But for some reason
occasionally  it comes out of select after more than one second . I
checked the man page but it does not help in concluding if this is ok
or not. Is this expected  or it is a bug. Most of this time is
consumed in   schedule_timeout . I am using 2.5.45 kernel but I
believe the same would  be the true for the latest kernel too. Any
thoughts or suggestion are welcome.

Thanks
Ram Gupta
