Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271133AbUJVAtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271133AbUJVAtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbUJVAqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:46:37 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:27260 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271133AbUJVAeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:34:20 -0400
Message-ID: <41785585.6030809@yahoo.com.au>
Date: Fri, 22 Oct 2004 10:34:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random>
In-Reply-To: <20041021224533.GB8756@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>
>looks reasonable. only cons is that this rejects on my tree ;), pages_*
>and protection is gone in my tree, replaced by watermarks[] using the
>very same optimal and proven algo of 2.4 (enabled by default of course).
>I'll reevaluate the false sharing later on.
>

May I again ask what you think is wrong with ->protection[] apart from
it being turned off by default? (I don't think our previous conversation
ever reached a conclusion...)

