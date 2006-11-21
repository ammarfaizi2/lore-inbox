Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031176AbWKUQqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031176AbWKUQqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031183AbWKUQqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:46:53 -0500
Received: from mail.suse.de ([195.135.220.2]:40630 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031176AbWKUQqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:46:52 -0500
From: Andi Kleen <ak@suse.de>
To: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
Date: Tue, 21 Nov 2006 17:46:39 +0100
User-Agent: KMail/1.9.5
Cc: Ray Lee <ray-lk@madrabbit.org>, linux-kernel@vger.kernel.org
References: <455B63EC.8070704@madrabbit.org> <p73psbhay8n.fsf@bingen.suse.de> <45632B30.9090506@lwfinger.net>
In-Reply-To: <45632B30.9090506@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211746.39173.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Shouldn't this problem be mentioned somewhere in the documentation, or did I miss something?

Possibly, but devices that cannot address at least 4GB are normally
categorized as "hardware bugs" (or less polite descriptions) and those don't 
tend to get much airtime in documentation.

-Andi
