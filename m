Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUIOUQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUIOUQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUIOUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:14:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52438 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267378AbUIOULb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:11:31 -0400
In-Reply-To: <4148991B.9050200@pobox.com>
To: Netdev <netdev@oss.sgi.com>
Cc: leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
MIME-Version: 1.0
Subject: Re: The ultimate TOE design
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 15 Sep 2004 14:11:04 -0600
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.51HF338 | June 21, 2004) at
 09/15/2004 14:11:11,
	Serialize complete at 09/15/2004 14:11:11
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've never understood why people are so interested in off-loading
networking. Isn't that just a multi-processor system where you can't
use any of the network processor cycles for anything else? And, of
course, to be cheap, the network processor will be slower, and much
harder to debug and update software.

If the PCI bus is too slow, or MTU's too small, wouldn't
it be better to fix those directly and use a fast host processor that can
also do other things when not needed for networking? And why have
memory on a NIC that can't be used by other things?

Why don't we off-load filesystems to disks instead?  Or a graphics
card that implements X ? :-) I'd rather have shared system resources--
more flexible. :-)

                                        +-DLS

