Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTJOQQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTJOQQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:16:08 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:22950 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263482AbTJOQQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:16:05 -0400
X-Sender-Authentication: net64
Date: Wed, 15 Oct 2003 18:16:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: incoming packet latency in 2.4.[18-20]
Message-Id: <20031015181602.07fd0959.skraw@ithnet.com>
In-Reply-To: <3F8D6BB0.7060809@nortelnetworks.com>
References: <3F8D6BB0.7060809@nortelnetworks.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 11:45:52 -0400
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> 
> There is an issue with incoming packet latency in the kernels mentioned.
> 
> It seems that if you send in a burst of messages, the amount of time it 
> takes to wake the listening process is dependent on the size of the 
> message burst.  2.4.18-2.4.20 all show this behaviour, 2.6 doesn't.
> 
> Some numbers for a udp message size of 2 bytes:
> 
> 1 packet, average latency 12 usecs
> 10 packets, average latency 66 usecs
> 100 packets, average latency 477 usecs
> 
> Is this a known issue?  Is there an easy way to fix this, or is it 
> something inherent in the 2.4 architecture?

Can you verify these numbers with 2.4.22 and 2.4.23-pre7 ?

Regards,
Stephan
