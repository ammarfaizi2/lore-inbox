Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUKLLax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUKLLax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 06:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUKLLax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 06:30:53 -0500
Received: from canuck.infradead.org ([205.233.218.70]:18962 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261538AbUKLLat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 06:30:49 -0500
Subject: Re: MODULE_PARM_DESC
From: Arjan van de Ven <arjan@infradead.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041112112356.GA19304@beton.cybernet.src>
References: <20041112112356.GA19304@beton.cybernet.src>
Content-Type: text/plain
Message-Id: <1100259041.4096.0.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 12 Nov 2004 12:30:41 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 11:23 +0000, Karel Kulhavy wrote:
> Hello
> 
> I have discovered that (at least some) modules have MODULE_PARM_DESC
> defined.
> 
> Is this intended to be displayed somehow by userspace tools (like
> modprobe --show-description, but nothing like this exists)? If yes, how
> can I have this written out for an arbitrary module?

yes; use the "modinfo" program not modprobe...


