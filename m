Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbUJYQvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUJYQvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUJYQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:51:17 -0400
Received: from canuck.infradead.org ([205.233.218.70]:63762 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262055AbUJYQux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:50:53 -0400
Subject: Re: [PATCH 2/17] Generic backward compatibility includes for 4level
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20041025160606.GA26306@verdi.suse.de>
References: <417CAA05.mail3Y411778M@wotan.suse.de>
	 <20041025103926.A31632@flint.arm.linux.org.uk>
	 <20041025160606.GA26306@verdi.suse.de>
Content-Type: text/plain
Message-Id: <1098723034.2798.35.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 25 Oct 2004 18:50:34 +0200
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

> > 
> > Don't we normally add do { } while (0) after empty macros which look like
> > a function?
> 
> iirc Rusty tried to come up with an example some time ago where it actually 
> made a difference, but failed. But I can change it. 


if (foo) 
	bar(); 
else 
	pml4_ERROR(x);
something_else();

-- 

