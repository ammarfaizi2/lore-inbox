Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVJDV7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVJDV7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVJDV7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:59:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:50100 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964995AbVJDV73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:59:29 -0400
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <29495f1d0510040944i6d8eb36aud85b63ff12608e8a@mail.gmail.com>
References: <1128404215.31063.32.camel@gaston>
	 <29495f1d0510040944i6d8eb36aud85b63ff12608e8a@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 07:59:10 +1000
Message-Id: <1128463151.6417.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 09:44 -0700, Nish Aravamudan wrote:

> 
> This can be schedule_timeout_interruptible(delay); and then you can
> get rid of the set_current_state(TASK_RUNNING);

Ah, those lovely new "do-it-all" helpers :) Thanks.

Ben.


