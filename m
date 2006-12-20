Return-Path: <linux-kernel-owner+w=401wt.eu-S964984AbWLTKy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWLTKy0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWLTKy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:54:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39144 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964984AbWLTKyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:54:25 -0500
Subject: Re: + down_write-preserve-local-irqs.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <200612201038.kBKAcN4L026466@shell0.pdx.osdl.net>
References: <200612201038.kBKAcN4L026466@shell0.pdx.osdl.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 11:54:23 +0100
Message-Id: <1166612063.3365.1367.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 02:38 -0800, akpm@osdl.org wrote:
> The patch titled
>      down_write(): preserve local irqs
> has been added to the -mm tree.  Its filename is
>      down_write-preserve-local-irqs.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: down_write(): preserve local irqs

excuse me? Am I missing something here?

down_write() is a sleeping function, right? what business does it have
to be *ever* called with irqs off?

if the answer is "none whatsoever", what good is saving irq state then?



