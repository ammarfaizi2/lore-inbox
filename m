Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUITWna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUITWna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUITWna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:43:30 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:24045 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265805AbUITWn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:43:27 -0400
References: <cone.1095649950.909900.10443.502@pc.kolivas.org> <20040920170216.GA7952@dominikbrodowski.de>
Message-ID: <cone.1095720189.669330.22937.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Add on-demand cpu-freq governor as default option
Date: Tue, 21 Sep 2004 08:43:09 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski writes:

> I'm sorry, but this can't be done at the moment. The default cpufreq
> governor needs to be one which can't fail to start up. And on-demand has
> quite strict requirements on when it allows to be started and when it
> doesn't.

Ah ok. Thanks. 

2 little questions please?

1. Would it be inappropriate to make it drop back to a different governor so 
that it can be selected?
2. Can cpu throttling be incorporated into this governor as well as a 
secondary mechanism for the lowest cpu frequency and as a primary 
mechanism for those cpus that don't support cpufreq?

Cheers,
Con

