Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965310AbWGJWtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbWGJWtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbWGJWtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:49:24 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:51028 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S965310AbWGJWtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:49:23 -0400
Message-ID: <44B2D96F.8080405@tls.msk.ru>
Date: Tue, 11 Jul 2006 02:49:19 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: functions returning 0 on success [was: [PATCH] Fix a memory leak
 in the i386 setup code]
References: <20060710221308.5351.78741.stgit@localhost.localdomain> <44B2D893.9050209@tls.msk.ru>
In-Reply-To: <44B2D893.9050209@tls.msk.ru>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
[]
> Ofcourse, later you understand that do_something() returns 0
> on failure, and the code is correct.  But the first impression
> (again, for me anyway) is that it's wrong.
> 
> In such cases when a routine returns 0 on error, I usually write
> it this way:
....
s/error/success/g.  Blah ;)
> 
>    if (request_resource() != 0)
>      fail()
[..]
/mjt
