Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423312AbWF1MWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423312AbWF1MWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423313AbWF1MWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:22:40 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:44181 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1423312AbWF1MWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:22:39 -0400
Message-ID: <44A2749D.7030705@kernel-api.org>
Date: Wed, 28 Jun 2006 14:22:53 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Petr Tesarik <ptesarik@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
References: <44A1858B.9080102@kernel-api.org> <1151495225.8127.68.camel@elijah.suse.cz>
In-Reply-To: <1151495225.8127.68.camel@elijah.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I looked at
> http://www.kernel-api.org/docs/online/2.6.17/da/dab/structsk__buff.html
> 
> and you apparently ignore kernel-doc for structs. Cf.
> include/linux/skbuff.h:177 ff.
> 
> Regards,
> Petr Tesarik
> 

There are several problems. The one you describe is probably caused by a
blank line between the struct and the related comment. Doxygen doesn't
recognize it correctly (and simply ignores the comment).

Lukas Jelinek

