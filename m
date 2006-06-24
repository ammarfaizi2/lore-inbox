Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWFXMQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWFXMQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWFXMQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:16:27 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:28264 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S964806AbWFXMQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:16:26 -0400
Date: Sat, 24 Jun 2006 14:15:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Michael Grundy <grundym@us.ibm.com>
Cc: Jan Glauber <jan.glauber@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060624121541.GD10403@osiris.ibm.com>
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624113641.GB10403@osiris.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just do a compare and swap operation on the instruction you want to replace,
> then do an smp_call_function() with the wait parameter set to 1 and passing
> a pointer to a function that does nothing but return.

Setting wait to 1 isn't necessary as well. Wondering if I get anything right
today...
