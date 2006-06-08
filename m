Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWFHA7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWFHA7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWFHA7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:59:23 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:59059
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932518AbWFHA7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:59:23 -0400
Message-ID: <44877659.2020103@microgate.com>
Date: Wed, 07 Jun 2006 19:59:05 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Fulghum <paulkf@microgate.com>
CC: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com> <20060607230202.GA12210@havoc.gtf.org> <44876D59.1000509@microgate.com>
In-Reply-To: <44876D59.1000509@microgate.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

Maybe you can lend some insight on what I should do.

I have posted multiple, working patches to correct
the build errors resultsing from random kernel configs.

But we appear to be in perpetual micromanagement by committee
mode where different people are giving conflicting
feedback of the "that's ugly" or "you shouldn't do that" kind.

I'm happy to accept any *patch* anyone wants to post
that corrects the build errors *and* does not break
the driver by removing the ability to optionally include
generic HDLC support in the synclink drivers *and*
is accepted by everyone here. Nothing that meets
those requirements has been posted yet.

(Randy's last patch comes as close as my last patch, but
Jeff says any code using conditional configuration is wrong
so that removes any patch posted so far)

I'm also happy to accept the status quo, the
driver works fine.

So where do we go from here?

--
Paul
