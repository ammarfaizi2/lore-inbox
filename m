Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVIBJV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVIBJV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 05:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVIBJV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 05:21:57 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:6122 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751161AbVIBJV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 05:21:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oPXuUnE+LPHikJpDIphl6TPZhAPeL3mmAebFGkf16YiPzmdZCYf3D1/mPBTdAx/ou0wsqQMT4J1Q546kJBr2W6KbB/FKiWSiCrcW33k4mbuqul4bLOcB+bF7EZ5FAgzew9xMcN3z/zLPJ0Z4N3TQ9hoXgRMKfWl5jdNqbIWwa1A=
Message-ID: <9a87484905090202214bc5bcbe@mail.gmail.com>
Date: Fri, 2 Sep 2005 11:21:51 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "liyu@WAN" <liyu@ccoss.com.cn>
Subject: Re: [Q] how to use syslogd to debug kernel ?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4317B309.3000404@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4317B309.3000404@ccoss.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, liyu@WAN <liyu@ccoss.com.cn> wrote:
> Hi, everyone.
> 
>     I know kernel oops can be seen by run 'dmesg', but if
> kernel crashed, we can not run it.   so I reconfigure syslogd
> to support remote forward, the debug machine content of

When the kernel crashes there's no guarantee that messages will reach
syslog. Actually there's no guarantee of anything - the kernel is
dead.
If you want to capture Oops messages in a more reliable fashion, then
use a serial console, netconsole or console on line-printer.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
