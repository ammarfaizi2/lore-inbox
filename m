Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbSI2U0d>; Sun, 29 Sep 2002 16:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSI2UZw>; Sun, 29 Sep 2002 16:25:52 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:22656 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S261771AbSI2UYS>; Sun, 29 Sep 2002 16:24:18 -0400
Date: Sun, 29 Sep 2002 13:30:11 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PROBLEM: kernel BUG in usb-ohci.c:902!
To: Stephen Marz <smarz@host187.south.iit.edu>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D9762D3.7000802@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I have noticed this problem in 2.5.39 except it occurs with the module
 > uhci-hcd.

No you haven't.  It doesn't have a file of that name, so you
didn't see such a BUG().  And I don't know about you, but my
copy of 2.5.39 has no BUG() anywhere in the ohci-hcd driver,
so it'd be hard seeing _any_ BUG() coming from there.

You might be hitting a different BUG(), but in that case you
would need to get your bug reports straight.

- Dave

