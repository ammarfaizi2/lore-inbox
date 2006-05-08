Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWEHOYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWEHOYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWEHOYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:24:17 -0400
Received: from dvhart.com ([64.146.134.43]:40417 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932183AbWEHOYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:24:17 -0400
Message-ID: <445F548A.703@mbligh.org>
Date: Mon, 08 May 2006 07:24:10 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org>
In-Reply-To: <20060507095039.089ad37c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's pretty harmless though.  The "load average" thing just means that the
> extra pdflush threads are twiddling thumbs waiting on some disk I/O -
> they'll later exit and clean themselves up.  They won't be consuming
> significant resources.

If they're waiting on disk I/O, they shouldn't be runnable, and thus
should not be counted as part of the load average, surely?

M.
