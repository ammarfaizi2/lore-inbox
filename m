Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVL2LIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVL2LIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVL2LIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:08:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5335 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932592AbVL2LIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:08:02 -0500
Date: Thu, 29 Dec 2005 12:07:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] updates XFS mutex patch
Message-ID: <20051229110748.GA11608@elte.hu>
References: <yq0zmmktbhk.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0zmmktbhk.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jes Sorensen <jes@trained-monkey.org> wrote:

> +#define mutex_destroy(lock)			do{}while(0)

FYI, there's now a mutex_destroy() op provided by mutex.h, which is 
functional if CONFIG_DEBUG_MUTEXES is enabled. (it hasnt been tested 
much though)

	Ingo
