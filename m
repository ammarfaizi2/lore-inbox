Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTEMWCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTEMWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:02:06 -0400
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:37351 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262497AbTEMWCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:02:05 -0400
Subject: Re: 2.5.69-mm4
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052864089.2419.203.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 May 2003 18:14:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got this on -mm4. (64bit dev_t patch is backed out too)

drivers/media/video/tuner.c:963: unknown field `name' specified in
initializer
drivers/media/video/tuner.c:963: warning: missing braces around
initializer
drivers/media/video/tuner.c:963: warning: (near initialization for
`client_template.dev')
drivers/media/video/tuner.c:963: warning: initialization from
incompatible pointer type
drivers/media/video/tuner.c:964: unknown field `flags' specified in
initializer
drivers/media/video/tuner.c:964: warning: initialization makes pointer
from integer without a cast
drivers/media/video/tuner.c:965: unknown field `driver' specified in
initializer
drivers/media/video/tuner.c:965: warning: initialization from
incompatible pointer type
make[3]: *** [drivers/media/video/tuner.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

Regards,

Shane

