Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTDXWZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbTDXWZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:25:39 -0400
Received: from d101.x-mailer.de ([212.162.12.2]:45508 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id S263847AbTDXWZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:25:38 -0400
From: Andreas Gietl <Listen@e-admin.de>
Organization: e-admin internet gmbh
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4+ptrace] fix side effects of the kmod/ptrace secfix
Date: Fri, 25 Apr 2003 00:37:45 +0200
User-Agent: KMail/1.5.1
Cc: bernhard.kaindl@gmx.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304250037.45133.Listen@e-admin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  You would need to restrict cmdline access to all root processes(not only
>  suid) and maybe even to all processes with different capabilites and > 
uid/gid
>  to work around problems in such processes. But you would break even more
> system monitoring stuff this way(I've even heard shutdown is affected)

i can confirm that shutdown (halt|reboot) does not work on my 2.4.21-rc1-ac1 
boxes. (gentoo + redhat).

But your patch does not seem to fix it.

-- 
e-admin internet gmbh
Andreas Gietl                                            tel +49 941 3810884
Ludwig-Thoma-Strasse 35                      fax +49 89 244329104
93051 Regensburg                                  mobil +49 171 6070008

PGP/GPG-Key unter http://www.e-admin.de/gpg.html




