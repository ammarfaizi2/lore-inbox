Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265683AbUFDIfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUFDIfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 04:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUFDIfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 04:35:53 -0400
Received: from any.83.147.212.vtx.ch ([212.147.83.66]:14476 "EHLO idfw.idsa.ch")
	by vger.kernel.org with ESMTP id S265683AbUFDIfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 04:35:52 -0400
Message-Id: <s0c0507d.050@idfw.idsa.ch>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Fri, 04 Jun 2004 10:35:20 +0200
From: "Francois Pernet" <WebMonster@idsa.ch>
To: <daniel@linux-user.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?ISO-8859-1?Q?R=E9p.=20:=20Re:=20.config=20question?=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx a lot. That solve my problem...
(except that with kernel 2.6.0, config file parameters are different,
but I can handle that ;-) ).

>>> anddan@linux-user.net 03.06.2004 17:13:11 >>>
Francois Pernet wrote:

> I've got a kernel already installed in my machine (SuSe Pro 9). I
would
> like to modify something and recompile the kernel. Since it has been
> installed from rpm, there is no .config in /usr/src/linux. Is there
any
> way to create this file from the image and modules, so i do not need
to
> verify all my config prior to change something ?

Suse Pro 9.1 has a copy of the running kernelconfig in
/proc/config.gz.
Type 'zcat /proc/config.gz > /usr/src/linux/.confg' to copy it to your

sourcetree.

Daniel Andersen
