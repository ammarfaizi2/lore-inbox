Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWEWV0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWEWV0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWEWV0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:26:53 -0400
Received: from mx.pathscale.com ([64.160.42.68]:10437 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932291AbWEWV0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:26:52 -0400
Subject: Re: [PATCH 1 of 10] ipath - fix spinlock recursion bug
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adawtccqwhg.fsf@cisco.com>
References: <bc968dacc8608566f4d2.1148409149@eng-12.pathscale.com>
	 <adawtccqwhg.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 23 May 2006 14:26:51 -0700
Message-Id: <1148419611.22550.11.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 14:09 -0700, Roland Dreier wrote:
> Thanks, I've put 1 through 10 into my git tree and asked Linus to pull.

Thanks.

> BTW, I just tried SRP with 2.6.17-rc4 + my for-2.6.18 tree + all of
> these patches, and immediately after connecting to a storage target I
> get the following:

Yes, I have another large pile of fixes to sort out.  Unfortunately, all
of them depend on some "code motion" driver changes that, in an ideal
world, should be deferred until 2.6.18.  Regenerating and testing them
against 2.6.17, without the code motion, is a big pain in the big
painful body region.

How do you feel about taking one code motion patch for 2.6.17?  :-)

	<b

