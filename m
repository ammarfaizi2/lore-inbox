Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTAAVfd>; Wed, 1 Jan 2003 16:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbTAAVfd>; Wed, 1 Jan 2003 16:35:33 -0500
Received: from ns.netrox.net ([64.118.231.130]:47833 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S265094AbTAAVfc>;
	Wed, 1 Jan 2003 16:35:32 -0500
Subject: Re: set_current_state(); vs current->state = bla;
From: Robert Love <rml@tech9.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301012205.13131.m.c.p@wolk-project.de>
References: <200301012205.13131.m.c.p@wolk-project.de>
Content-Type: text/plain
Organization: 
Message-Id: <1041457559.1638.2.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 01 Jan 2003 16:45:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-01 at 16:05, Marc-Christian Petersen wrote:

> $subject says it all. Is there _any_ reason why not to use set_current_state?

If you do not need the memory barrier... but then you can use
__set_current_state().

So, no, we should not open code this ever.

	Robert Love

