Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTINAzr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 20:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTINAzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 20:55:46 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:7696
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262273AbTINAzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 20:55:45 -0400
Subject: Re: [RFC] Enabling other oom schemes
From: Robert Love <rml@tech9.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030913220401.GA17528@hh.idb.hist.no>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
	 <20030913174825.GB7404@mail.jlokier.co.uk>
	 <1063476152.24473.30.camel@localhost>
	 <20030913220401.GA17528@hh.idb.hist.no>
Content-Type: text/plain
Message-Id: <1063500950.24473.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sat, 13 Sep 2003 20:55:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-13 at 18:04, Helge Hafting wrote:

> So a "complicated" oom handler need to preallocate all the memory
> it might ever need.  Not impossible.

Right.  I was just pointing it out.

Preallocating isn't necessarily possible e.g. you need something
dynamically, need to call back into user-space, etc.

	Robert Love


