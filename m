Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUAATIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 14:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUAATIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 14:08:54 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:46285 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264549AbUAATIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 14:08:53 -0500
Date: Fri, 02 Jan 2004 08:07:03 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: How to avoid 'lost interrupt' messages post-resume?
In-reply-to: <1072939036.768.39.camel@gaston>
To: benh@kernel.crashing.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1072984022.22058.3.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1072932095.6722.22.camel@laptop-linux>
 <1072939036.768.39.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply.

I'll look into that area some more.

Regards,

Nigel

On Thu, 2004-01-01 at 21:09, Benjamin Herrenschmidt wrote:
> You probably had a pending IDE request or something like that... IDE
> in 2.4.x doesn't quite have the infrastructure to deal properly with
> suspend & resume...

-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

