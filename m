Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVHWUku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVHWUku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVHWUku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:40:50 -0400
Received: from [62.206.217.67] ([62.206.217.67]:20130 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S932387AbVHWUkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:40:49 -0400
Message-ID: <430B89BE.1020600@trash.net>
Date: Tue, 23 Aug 2005 22:40:30 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: Sven-Thorsten Dietrich <sven@mvista.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050823201004.77101.qmail@web33310.mail.mud.yahoo.com>
In-Reply-To: <20050823201004.77101.qmail@web33310.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
> None of this is helpful, but since no one has
> been able to tell me how to tune it to provide
> absolute priority to the network stack I'll
> assume it can't be done.

The network stack already has priority over user processes,
except when executed in process context, so preemption has
no direct impact on briding or routing performance.

The reason why noone answered your question is because you
don't ask but claim or assume.
