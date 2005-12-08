Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVLHQWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVLHQWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLHQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:22:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26824 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932199AbVLHQWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:22:02 -0500
Subject: Re: How to enable/disable security features on mmap() ?
From: Arjan van de Ven <arjan@infradead.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1134058814.1615.176.camel@capoeira>
References: <43983EBE.2080604@labri.fr>
	 <1134051272.2867.63.camel@laptopd505.fenrus.org>
	 <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr>
	 <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr>
	 <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
	 <1134056272.2867.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com>
	 <1134058814.1615.176.camel@capoeira>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 17:21:57 +0100
Message-Id: <1134058917.2867.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 17:20 +0100, Xavier Bestel wrote:
> If you only randomize by one or two bytes, the attacker just has to
> retry once or twice to have his exploit work.

in addition the stack pointer needs to be 16 byte aligned in the first
place ;)

