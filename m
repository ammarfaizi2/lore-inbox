Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWG3Oyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWG3Oyt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWG3Oyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:54:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26752 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750924AbWG3Oys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:54:48 -0400
Subject: Re: FP in kernelspace
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44CCC4CA.6000208@argo.co.il>
References: <44CC97A4.8050207@gmail.com>  <44CCC4CA.6000208@argo.co.il>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 30 Jul 2006 16:54:43 +0200
Message-Id: <1154271283.2941.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So 2 questions are:
> > 1) howto FP in kernel
> >
> kernel_fpu_begin();
> c = d * 3.14;
> kernel_fpu_end();
> 

unfortunately this only works for MMX not for real fpu (due to exception
handling uglies)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

