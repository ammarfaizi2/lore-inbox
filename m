Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTLYWHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 17:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTLYWHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 17:07:24 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:9897 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S264373AbTLYWHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 17:07:22 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 problems
Date: Thu, 25 Dec 2003 16:07:31 -0600
User-Agent: KMail/1.5.94
References: <Pine.LNX.4.44.0312251936200.3243-300000@eglifamily.dnsalias.net>
In-Reply-To: <Pine.LNX.4.44.0312251936200.3243-300000@eglifamily.dnsalias.net>
Cc: dan@eglifamily.dnsalias.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312251607.31868.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 December 2003 02:57 pm, dan@eglifamily.dnsalias.net wrote:
> I grabbed the 2.6.0 code yesterday. But when I tried to compile a
> modular kernel, I got a *LOT* of unresolved symbols in the modules. I'm
> attaching the stderr output from depmod's run of make modules_install.
	I had this problem with a RH9 install. Instead of modutils, upgrade the the 
latest module-init-tools from ftp://kernel.org.
	The problem is that most of the module loading code has been moved from 
userspace to kernel code to make module loading more portable. Be sure to 
follow the upgrade instructions carefully. If done correctly it will keep 
your old modutils in case you load a 2.4.x kernel and will default to the new 
module-init-tools for 2.6.x kernels.
	 
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
