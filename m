Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTAQGzD>; Fri, 17 Jan 2003 01:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbTAQGzC>; Fri, 17 Jan 2003 01:55:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:41445 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267410AbTAQGzC>;
	Fri, 17 Jan 2003 01:55:02 -0500
Date: Thu, 16 Jan 2003 23:05:06 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: wli@holomorphy.com, gone@us.ibm.com, akpm@zip.com.au,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: asm-i386/mmzone.h macro paren/eval fixes
Message-Id: <20030116230506.70fa96f9.akpm@digeo.com>
In-Reply-To: <181070000.1042786246@titus>
References: <20030117063900.GA1036@holomorphy.com>
	<181070000.1042786246@titus>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 07:03:52.0962 (UTC) FILETIME=[98014620:01C2BDF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Ugh. That's why I broke struct page out into a seperate header file.
> OK, Andrew ... now do you believe me? ;-) ;-)

I never disagreed.  But the dependency chain for struct page is pretty long,
too.

The core problem is the practice of putting things which define stuff in the
same header as things which do stuff.

