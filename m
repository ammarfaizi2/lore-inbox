Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUFNIgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUFNIgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUFNIec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:34:32 -0400
Received: from holomorphy.com ([207.189.100.168]:2719 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262256AbUFNIeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:34:18 -0400
Date: Mon, 14 Jun 2004 01:34:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [12/12] fix thread_info.h ignoring __HAVE_THREAD_FUNCTIONS
Message-ID: <20040614083412.GJ1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com> <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com> <20040614004701.GZ1444@holomorphy.com> <20040614004855.GA1444@holomorphy.com> <20040614081639.GI7162@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614081639.GI7162@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:48:55PM -0700, William Lee Irwin III wrote:
>>  * Check __HAVE_THREAD_FUNCTIONS in include/linux/thread_info.h (m68k)
>> This fixes the build on m68k; its thread_info functions need to be used.

On Mon, Jun 14, 2004 at 09:16:39AM +0100, Christoph Hellwig wrote:
> I don't like this one a lot and prefer to discuss it with the m68k folks
> first.  Given they didn't sent it to Linus themselves I guess they're not
> completely proud of it ;-)

Including this in the series was a mistake, though it one I thought about
and made a wrong decision on. I'll defer to the m68k arch people for this
entirely.


-- wli
