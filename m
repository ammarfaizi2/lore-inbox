Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264191AbUFFWZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUFFWZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 18:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUFFWZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 18:25:29 -0400
Received: from [213.146.154.40] ([213.146.154.40]:18119 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264191AbUFFWZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 18:25:28 -0400
Subject: Re: SPF on kernel.org
From: David Woodhouse <dwmw2@infradead.org>
To: jeremy@rootservices.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4864.68.254.2.84.1086559839.squirrel@webmail.rootservices.net>
References: <4864.68.254.2.84.1086559839.squirrel@webmail.rootservices.net>
Content-Type: text/plain
Date: Sun, 06 Jun 2004 23:24:30 +0100
Message-Id: <1086560670.29255.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 18:10 -0400, Jeremy D. May wrote:
> has SPF records even been thought of for kernel.org? maybe this is the
> wrong place to ask? if so, can i get the right place to ask about it.

SPF records would need to be on vger.kernel.org not on kernel.org. And
yes, this is the wrong place to ask. The right place would be
postmaster@vger.kernel.org. But I wouldn't bother -- it's manned by
people who have at least a modicum of clue, so I assume they won't do
anything as stupid as publishing SPF records. SPF is a fundamentally
broken mechanism which breaks valid email. It should not be encouraged
even by publishing no-op records ending in '?all'.

-- 
dwmw2

