Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWEIQIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWEIQIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWEIQIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:08:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38299 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751286AbWEIQIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:08:07 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Date: Tue, 9 May 2006 18:07:57 +0200
User-Agent: KMail/1.9.1
Cc: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <4460AC06.4000303@mbligh.org> <20060509155153.GJ7834@cl.cam.ac.uk>
In-Reply-To: <20060509155153.GJ7834@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091807.57522.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Anybody want to comment on the performance impact of making
> local_irq_* non-inline functions?

I would guess for that much inline code it will be even a win to not
inline because it will save icache.

-Andi
