Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUFNXcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUFNXcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUFNXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:32:18 -0400
Received: from quechua.inka.de ([193.197.184.2]:1459 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264584AbUFNXcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:32:16 -0400
Date: Tue, 15 Jun 2004 01:32:15 +0200
From: Bernd Eckenfels <be-mail2004@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: How to turn off IPV6 (link local)
Message-ID: <20040614233215.GA10547@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While solving the debian bug #253590 against net-tools, I discovered, that
it is not possible to turn off the link local ipv6 addresses.

net.ipv6.conf.default.autoconf does work for the received prefixes, but does
not avoid the link local configuration. (this is btw a documentation error)

I would not mind the link local address much, if there wont be some
applications (like mozilla) trying to actually use that address to reach
internet site.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=253590

So my question is, how can one prevent linux kernel with build in ipv6 from
adding the link local prefix, and are the prerequisites of an ipv6 enabled
application to not prefer link local prefix to ipv4?

Greetings
Bernd

PS:

autoconf - BOOLEAN
        Configure link-local addresses using L2 hardware addresses.
        Default: TRUE
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
