Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTIHD2f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 23:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTIHD2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 23:28:34 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:46049 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261217AbTIHD2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 23:28:33 -0400
Date: Mon, 8 Sep 2003 13:28:32 +1000 (EST)
From: Michael Still <mikal@stillhq.com>
To: carbonated beverage <ramune@net-ronin.org>
Cc: torvalds@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] bk chmod needed for scripts/*
In-Reply-To: <20030907215953.GA11020@net-ronin.org>
Message-ID: <Pine.LNX.4.44.0309081327420.20775-100000@diskbox.stillhq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Sep 2003, carbonated beverage wrote:

> 	The various executables in the scripts/ directory are marked 644 in
> BK.

Yes, but most of them do a:

	$(PERL) ./scripts/foo

Which removes the need for the executable bit (for the makefiles at 
least). Is there a specific problem you're having?

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson

