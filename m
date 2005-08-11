Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVHKPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVHKPwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVHKPwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:52:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39563 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932220AbVHKPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:51:59 -0400
Subject: Re: Kernel 2.6.5 - Compaq Fibre Channel 64-bit/66Mhz HBA
From: Arjan van de Ven <arjan@infradead.org>
To: Bolke de Bruin <bdbruin@aub.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42FB72DE.8000703@aub.nl>
References: <42FB72DE.8000703@aub.nl>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 17:51:50 +0200
Message-Id: <1123775510.3201.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 17:46 +0200, Bolke de Bruin wrote:
> Hello,
> 
> The company I work for is investigating a switch from Windows 2000 to a 
> Linux based setup for its databases. Because of a dependancy on a third 
> party we need to settle on kernel 2.6.5. 


kernel.org 2.6.5 or some vendor 2.6.5? If the later.. you should ask the
vendor as well

> So the basic question is. Does this controller work on kernel 2.6.5?
> 

in kernel.org 2.6.5 the answer is no; it hasn't been adjusted to the 2.6
kernel really (heck hardly to the 2.4 kernel) so isn't reliable at all
for business use (or in fact any use). Think "no error handling" and
things like that.


