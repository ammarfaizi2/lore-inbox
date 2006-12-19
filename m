Return-Path: <linux-kernel-owner+w=401wt.eu-S932823AbWLSQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWLSQWz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbWLSQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:22:55 -0500
Received: from www.tedsautoline.com ([69.222.0.225]:36195 "HELO
	mail.webhostingstar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753484AbWLSQWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:22:54 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 11:22:54 EST
Message-ID: <20061219101424.yjwfjsykcbs0o0wc@69.222.0.225>
Date: Tue, 19 Dec 2006 10:14:24 -0600
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: 2.6.20-rc1-git compilation error
	drivers/connector/connector.c:138: error: ?struct work_struct? has no
	member named ?management?
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org


2.6.20-rc1-git compilation error drivers/connector/connector.c:138:  
error: ?struct work_struct? has no member named ?management?

$ date
Tue Dec 19 10:12:17 CST 2006
$ git pull
Already up-to-date.
$ make -j 8
   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CHK     include/linux/compile.h
   CC      drivers/connector/connector.o
drivers/connector/connector.c: In function ?cn_call_callback?:
drivers/connector/connector.c:138: error: ?struct work_struct? has no  
member named ?management?
drivers/connector/connector.c:138: error: ?struct work_struct? has no  
member named ?management?
make[2]: *** [drivers/connector/connector.o] Error 1
make[1]: *** [drivers/connector] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....


xboom

