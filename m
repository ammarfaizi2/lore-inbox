Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUBIXMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUBIXMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:12:21 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:33428 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265357AbUBIXMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:12:19 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Limit hash table size
References: <B05667366EE6204181EABE9C1B1C0EB58024C3@scsmsx401.sc.intel.com>
	<20040205162355.7a4d4858.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 09 Feb 2004 18:12:13 -0500
In-Reply-To: <20040205162355.7a4d4858.akpm@osdl.org>
Message-ID: <yq0n07ru9te.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>>  Andrew,
>> 
>> Will you merge the changes in the network area first while I'm
>> working on the solution suggested here for inode and dentry? The
>> 2GB tcp hash is the biggest problem for us right now.

Andrew> Is there some reason why TCP could not also end up creating
Andrew> 100's of millions of objects?

Andrew,

I think the likelihood that TCP will generate that is quite small,
it would require a fairly significant number of network interfaces and
I doubt people with 1TB RAM boxes will throw in 256 10GigE interfaces
and run them all flat out.

Cheers,
Jes
