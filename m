Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbTCOFju>; Sat, 15 Mar 2003 00:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbTCOFju>; Sat, 15 Mar 2003 00:39:50 -0500
Received: from holomorphy.com ([66.224.33.161]:23504 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261400AbTCOFjs>;
	Sat, 15 Mar 2003 00:39:48 -0500
Date: Fri, 14 Mar 2003 21:50:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315055014.GO20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com> <20030315053053.GM20188@holomorphy.com> <2650000.1047707016@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2650000.1047707016@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 09:43:38PM -0800, Martin J. Bligh wrote:
> You'd also have to stop sending all your IO over a NUMA backplane ...

Oh yes, there is also that.


At some point in the past, I wrote:
>> This locking issue may just need more cpus to bring out.

On Fri, Mar 14, 2003 at 09:43:38PM -0800, Martin J. Bligh wrote:
> More than 32 CPUs? Hmmmm.

More than 4.


-- wli
