Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752913AbWKCBY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbWKCBY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbWKCBY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:24:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:57704 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752911AbWKCBY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:24:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NcGxJObYC8GImVMK/lo45+SU5x0gBEFKcguLbFVOpoDJXFsLzGCDgQ2CXPOPRgLU7MTkKb7HeDOsI3+I7RbTKJ4UQmzIMX4Zv2UPOG/N9JSgPhflUj3esFYGRuYdRpQIr/YZOxuiMI52IBMYlW0Tkh1KFQM81yfJnS/4TSWtv7w=
Date: Fri, 3 Nov 2006 04:24:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [PATCH] tda826x: use correct max frequency
Message-ID: <20061103012450.GC4957@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparse "defined twice" warning

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/media/dvb/frontends/tda826x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb/frontends/tda826x.c
+++ b/drivers/media/dvb/frontends/tda826x.c
@@ -121,7 +121,7 @@ static struct dvb_tuner_ops tda826x_tune
 	.info = {
 		.name = "Philips TDA826X",
 		.frequency_min = 950000,
-		.frequency_min = 2175000
+		.frequency_max = 2175000
 	},
 	.release = tda826x_release,
 	.sleep = tda826x_sleep,

