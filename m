Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVDFBW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVDFBW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVDFBW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:22:59 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:48495 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262063AbVDFBWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:22:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=b4Z5xohsLXy2/2N0rFJTn42fA3ZPvalMnTJW8cOYpM0T3P4rXFxwJEIiI1oqGQ+xEDp8wgQW9zZwUJ7fv/grJ3CZ4n9+8oWwGFiZ4hvsFZMc5Bbg6zeMYhO43vgoSwDmtZKvyeS1d4yP5CRXDI17lXv5OvKPZd0y41Q2Kpct9QQ=
Message-ID: <425339E3.8030404@gmail.com>
Date: Tue, 05 Apr 2005 20:22:43 -0500
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050329)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2-mm1 compile error in mmx.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc2-mm1 fails to build for me with the following error:

arch/i386/lib/mmx.c:374: error: conflicting types for `mmx_clear_page'
include/asm/mmx.h:11: error: previous declaration of `mmx_clear_page'
make[1]: *** [arch/i386/lib/mmx.o] Error 1
make: *** [arch/i386/lib] Error 2

I hope this is useful-- I apologize if it is not.  (I browsed the 
archives, and no one seems to be complaining of the same thing so far.) 
  I'm not subscribed to the list, but I'll gladly provide more 
information if you CC me on a response.
