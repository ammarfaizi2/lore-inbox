Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUBYDIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUBYDIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:08:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:62855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262427AbUBYDIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:08:48 -0500
Date: Tue, 24 Feb 2004 19:09:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Message-Id: <20040224190903.586bec30.akpm@osdl.org>
In-Reply-To: <403C0DBF.7040608@matchmail.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<403C0DBF.7040608@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
>  I have a dual CPU server that won't boot 2.6.3-mm3.  It will however 
>  boot vanilla 2.6.3.
> 
>  Right after is says "uncompressing kernel" and "booting" it hangs.

Please triple-check the .config, then boot with

	earlyprintk=vga

or set up a serial console and boot with

	earlyprintk=serial[,ttySn[,baudrate]]


