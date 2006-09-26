Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWIZVDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWIZVDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWIZVDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:03:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64188 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932317AbWIZVDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:03:17 -0400
Subject: Re: [PATCH] avr32 architecture
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: =?ISO-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@atmel.com>,
       akpm@osdl.org
In-Reply-To: <200609261601.k8QG1Txd005700@hera.kernel.org>
References: <200609261601.k8QG1Txd005700@hera.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 22:02:56 +0100
Message-Id: <1159304576.3309.54.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 16:01 +0000, Linux Kernel Mailing List wrote:
> [PATCH] avr32 architecture 

pmac /pmac/git/linux-2.6 $ make ARCH=avr32 headers_check
  CHK     include/linux/version.h
make[1]: `scripts/unifdef' is up to date.
  CHECK   include/asm/user.h
  CHECK   include/asm/unistd.h
/pmac/git/linux-2.6/usr/include/asm/unistd.h requires linux/linkage.h, which does not exist in exported headers
make[2]: *** [/pmac/git/linux-2.6/usr/include/asm/.check.unistd.h] Error 1

-- 
dwmw2

