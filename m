Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWKBOjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWKBOjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWKBOjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:39:20 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:26755 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750913AbWKBOjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:39:19 -0500
Subject: Re: [Patch 0/5] I/O statistics through request queues
From: martin <mp3@de.ibm.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061025104217.GB4281@kernel.dk>
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com>
	 <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com>
	 <20061024162050.GK4281@kernel.dk> <453E9C18.70803@de.ibm.com>
	 <20061025051238.GO4281@kernel.dk> <453F3D4E.4020608@de.ibm.com>
	 <20061025104217.GB4281@kernel.dk>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 15:39:16 +0100
Message-Id: <1162478356.6902.144.camel@dix>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, Andrew,
I am not pursueing this patch set. I have convinced myself that blktrace
is capable of being used as a an analysis tool for low level I/O
performance, if invoced with appropriate settings. In our tests, we
limited traces to Issue/Complete events, cut down on relay buffers, and
redirected traces to a network connection instead of filling locally
attached storage up. Cost is about 2 percent, as advertised.

Thanks,
Martin

