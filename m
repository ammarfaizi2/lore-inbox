Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUHDVlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUHDVlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUHDVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:40:49 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:44894 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267446AbUHDVdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:33:32 -0400
Date: Wed, 4 Aug 2004 23:34:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       kernel@kolivas.org, linux-kernel@vger.kernel.org,
       Rick Lindsley <ricklind@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc2-mm2, schedstat-2.6.8-rc2-mm2-A4.patch
Message-ID: <20040804213454.GA7661@mars.ravnborg.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
	linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040804122414.4f8649df.akpm@osdl.org> <211490000.1091648060@flay> <20040804212658.GA26023@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804212658.GA26023@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 11:26:58PM +0200, Ingo Molnar wrote:
 
> I fixed a number of cleanliness items, readying this patch for a
> mainline merge:
> 
>  - added kernel/Kconfig.debug for generic debug options (such as 
>    schedstat) and removed tons of debug options from various arch
>    Kconfig's, instead of adding a boatload of new SCHEDSTAT entries. 
>    This felt good.

Randy Dunlap has posted a patch for this several times.
This has seen some review so the preferred starting point.

	Sam
