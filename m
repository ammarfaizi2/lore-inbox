Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265917AbTF3V0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbTF3V0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:26:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35472
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265917AbTF3VZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:25:04 -0400
Subject: Re: PTY DOS vulnerability?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306302331.38071.fredrik@dolda2000.cjb.net>
References: <200306301613.11711.fredrik@dolda2000.cjb.net>
	 <1056995729.17590.19.camel@dhcp22.swansea.linux.org.uk>
	 <200306302331.38071.fredrik@dolda2000.cjb.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057008994.17589.40.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jun 2003 22:36:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-30 at 22:31, Fredrik Tolf wrote:
> That is true, though, of course. Stupid me not to think about 
> that. However, that means that an administrator who could find 
> himself being under such an attack might not think about it 
> either. Also, from the outside, the ssh client just does 
> nothing, making it look as if the server is unresponsive. Of 
> course, the exact error is logged to the server's syslog, but if 
> you can't view it, then you won't know about it.
> 
> So all in all, do you think I should implement a per-user 
> resource limit on PTYs?

There are a whole collection of things that would benefit from that kind
of management - go for it but make it possible to add other stuff too

