Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136264AbREGQP5>; Mon, 7 May 2001 12:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136253AbREGQPr>; Mon, 7 May 2001 12:15:47 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:11919 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136264AbREGQPh>; Mon, 7 May 2001 12:15:37 -0400
Message-ID: <3AF6CA1B.9849CE6A@redhat.com>
Date: Mon, 07 May 2001 12:15:23 -0400
From: Ben LaHaise <bcrl@redhat.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero^H^H^H^Hsingle copy pipe
In-Reply-To: <mailman.989055541.17259.linux-kernel2news@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> I'm now running with the patch for several hours, no problems.
> 
> bw_pipe transfer rate has nearly doubled and the number of context
> switches for one bw_pipe run is down from 71500 to 5500.
> 
> Please test it.

Any particular reason for not using davem's single copy kiobuf based
code?

		-ben
