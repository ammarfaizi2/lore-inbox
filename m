Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318180AbSGWTEF>; Tue, 23 Jul 2002 15:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSGWTEF>; Tue, 23 Jul 2002 15:04:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5900 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318180AbSGWTEF>;
	Tue, 23 Jul 2002 15:04:05 -0400
Date: Tue, 23 Jul 2002 21:14:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: DocBook - kernel-doc error messages
Message-ID: <20020723211424.A9242@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up the DocBook makefile I have seen the following errormessage
as produced by scripts/kernel-doc:

Use of uninitialized value in string ne at scripts/kernel-doc line 641, <IN> line 247.
Use of uninitialized value in string ne at scripts/kernel-doc line 661, <IN> line 247.
Use of uninitialized value in join or string at scripts/kernel-doc line 363, <IN> line 247.

Any brave perl guru that is able to hack kernel-doc to at least provide
a filename, to give a hint where to search?
Obviously a better approach would be to fix this error in kernel-doc.

The above output can be reproduced by the following command:

src/linux$ scripts/kernel-doc -docbook include/linux/skbuff.h > x

	Sam

