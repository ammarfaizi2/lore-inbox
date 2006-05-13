Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWEMGs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWEMGs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 02:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWEMGs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 02:48:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932224AbWEMGs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 02:48:28 -0400
Subject: Re: +
	rewritten-backlight-infrastructure-for-portable-apple-computers.patch added
	to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@hansmi.ch, adaplas@pol.net, benh@kernel.crashing.org,
       rpurdie@rpsys.net
In-Reply-To: <200605110505.k4B55JdF004102@shell0.pdx.osdl.net>
References: <200605110505.k4B55JdF004102@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sat, 13 May 2006 08:48:19 +0200
Message-Id: <1147502900.4072.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 22:02 -0700, akpm@osdl.org wrote:
> X 15
> +
> +/* Protect the pmac_backlight variable */
> +DECLARE_MUTEX(pmac_backlight_sem);
> +


please just make this a real mutex rather than a semaphore while you're
rewriting all this code anyway ;)


