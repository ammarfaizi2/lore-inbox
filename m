Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVKBMjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVKBMjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVKBMjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:39:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41150 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932673AbVKBMjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:39:35 -0500
Subject: Re: Trouble unloading a module..
From: Arjan van de Ven <arjan@infradead.org>
To: James Hansen <linux-kernel-list@f0rmula.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4368AD58.6050809@f0rmula.com>
References: <43664B31.3000305@f0rmula.com>
	 <1130919119.2826.5.camel@laptopd505.fenrus.org>
	 <4368AD58.6050809@f0rmula.com>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 13:39:30 +0100
Message-Id: <1130935171.2826.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[84.119.168.181 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 12:13 +0000, James Hansen wrote:
> I was thinking that there may have been a common issue that would allow 
> a driver oops the kernel if not unloaded properly.  Obviously not.
> 
> Thanks for any advice, it's much appreciated.

static struct pci_device_id nfp_pci_tbl[] __devinitdata = {

you probably don't want that __devinitdata there....


