Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWD3QcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWD3QcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 12:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWD3QcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 12:32:24 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:51876 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751161AbWD3QcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 12:32:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h0txUi6U/hREx4ryviyL0t3WD1kd2gsaMGKdyVCU6ELQgcEcKQsVXHxq6V/K6nMOeBylTN3KUOd7/h4RpR3vUg0nCbKHOweSXApLprsqHFFvQVTsukTqKZ5MOxwTxYZv/tWDC3KJOUXIrjB6mNB+s4h4pQ0g6KtuOeCWREWGncc=
Message-ID: <bda6d13a0604300932u10d8a05cw84094ed50c669f8d@mail.gmail.com>
Date: Sun, 30 Apr 2006 09:32:23 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: World writable tarballs
In-Reply-To: <1146379675.8217.2.camel@minerva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146356286.10953.7.camel@hammer>
	 <200604300148.12462.s0348365@sms.ed.ac.uk>
	 <bda6d13a0604292159r3187b76fg56b137816480bf2a@mail.gmail.com>
	 <1146379675.8217.2.camel@minerva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Isn't it just an extra ten seconds to type the 'sudo' in front of 'make
> modules_install' and enter your password?  I guess I totally don't get
> it.
No sudo.
Besides, the next command after make modules_install is mount.

Besides, if it weren't the fact that the tarball has world-writable files, this
would be more secure than compiling as a normal user. Instead of just
hijacking some user account, they now have to do that followed by
somehow getting my root password.

I disallowed password authentication for root over ssh some time ago.
