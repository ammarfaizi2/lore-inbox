Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267398AbSLLBtG>; Wed, 11 Dec 2002 20:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267401AbSLLBtG>; Wed, 11 Dec 2002 20:49:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11536 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267398AbSLLBtF>;
	Wed, 11 Dec 2002 20:49:05 -0500
Date: Wed, 11 Dec 2002 17:55:27 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic MP_BUSSES and IRQ_SOURCES for 2.4.21-pre1
Message-ID: <20021212015527.GK16615@kroah.com>
References: <20021212015326.GI16615@kroah.com> <20021212015454.GJ16615@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021212015454.GJ16615@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.813, 2002/12/11 17:44:54-08:00, greg@kroah.com

mpparse.c: Fix a minor code formatting issue.


diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Wed Dec 11 17:49:48 2002
+++ b/arch/i386/kernel/mpparse.c	Wed Dec 11 17:49:48 2002
@@ -234,7 +234,7 @@
 	if (m->mpc_apicid > MAX_APICS) {
 		printk("Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
-			--num_processors;
+		--num_processors;
 		return;
 	}
 	ver = m->mpc_apicver;
