Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSKRUNj>; Mon, 18 Nov 2002 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSKRUNj>; Mon, 18 Nov 2002 15:13:39 -0500
Received: from holomorphy.com ([66.224.33.161]:481 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264620AbSKRUNj>;
	Mon, 18 Nov 2002 15:13:39 -0500
Date: Mon, 18 Nov 2002 12:17:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rml@tech9.net, riel@surriel.com, akpm@zip.com.au
Subject: Re: unusual scheduling performance
Message-ID: <20021118201748.GL23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, mingo@elte.hu, rml@tech9.net,
	riel@surriel.com, akpm@zip.com.au
References: <20021118081854.GJ23425@holomorphy.com> <705474709.1037608454@[10.10.2.3]> <20021118165316.GK23425@holomorphy.com> <3DD92914.1060301@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD92914.1060301@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 09:53:24AM -0800, Dave Hansen wrote:
> I'm seeing the same thing.  In my pagecache warmup test, I do 20 greps 
> to pull in a 10-gig fileset.  Each grep works on 1/20th of the files.
[...]
> So, schedule() is being called a _lot_ more.  But, for some reason, 
> the slower one wasn't caught doing __copy_to_user() as much.
> Bill, does this look like what you're seeing?

No, I'm seeing strange load balancing behavior. But you seem to have
tripped over a somewhat more severe anomaly.


Bill
