Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVAaOHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVAaOHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVAaOHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:07:00 -0500
Received: from canuck.infradead.org ([205.233.218.70]:5895 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261206AbVAaOG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:06:58 -0500
Subject: Re: inter-module-* removal.. small next step
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
In-Reply-To: <20050131135631.GA6694@wohnheim.fh-wedel.de>
References: <20050130180016.GA12987@infradead.org>
	 <1107132112.783.219.camel@baythorne.infradead.org>
	 <1107159869.4221.53.camel@laptopd505.fenrus.org>
	 <20050131135631.GA6694@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Jan 2005 14:06:47 +0000
Message-Id: <1107180407.19262.164.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 14:56 +0100, Jörn Engel wrote:
> 
> How about this one?  It's actually less messy inside kernel/Makefile.
> 
> Completely untested, though.

Surely it would suffice just to make MTD_GEN_PROBE and MTD_DOCPROBE
select it, rather than all the _users_ of each?

-- 
dwmw2

