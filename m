Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWHIV3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHIV3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWHIV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:29:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33733 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750940AbWHIV3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:29:35 -0400
Date: Wed, 9 Aug 2006 22:29:31 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] dm-mpath: kmalloc+memset -> kzalloc
Message-ID: <20060809212931.GQ18633@agk.surrey.redhat.com>
Mail-Followup-To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <20060809151746.GA31694@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060809151746.GA31694@rere.qmqm.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 05:17:46PM +0200, Michał Mirosław wrote:
> Use kzalloc() instead of kmalloc() + memset().
 
Thanks,
Alasdair
-- 
agk@redhat.com
