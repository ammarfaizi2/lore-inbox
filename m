Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUDAJZB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbUDAJZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:25:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:14048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262815AbUDAJY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:24:59 -0500
Date: Thu, 1 Apr 2004 01:24:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: rusty@rustcorp.com.au, dmorris@metavize.com, jamie@shareable.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
Message-Id: <20040401012452.2c467108.akpm@osdl.org>
In-Reply-To: <20040401003418.6485d6bf.akpm@osdl.org>
References: <40311703.8070309@metavize.com>
	<20040217051911.6AC112C066@lists.samba.org>
	<20040331165656.GG19280@mail.shareable.org>
	<406B0219.3000309@metavize.com>
	<20040331183243.GA20418@mail.shareable.org>
	<406B1522.9050204@metavize.com>
	<1080785801.32535.116.camel@bach>
	<20040401003418.6485d6bf.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  >  > Here ya go. :)
> 
>  Dirk, thanks for that.  It's worth its weight.
> 
>  > 
>  >  Doesn't work for me (2.6.5-rc1 Debian unstable 2xi686).
> 
>  It works here.

Then again, I only saw the debug messages on the wakeup path.  I'm unable
to trigger the warning in futex_wait().
