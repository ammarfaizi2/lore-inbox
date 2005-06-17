Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVFQO2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVFQO2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVFQO2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:28:44 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24450 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261985AbVFQO2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:28:42 -0400
Message-ID: <42B2DDFA.8020200@nortel.com>
Date: Fri, 17 Jun 2005 08:28:10 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
References: <42B1DBF1.4020904@nortel.com> <20050616135708.4876c379.akpm@osdl.org> <42B20317.6000204@nortel.com> <20050616162933.25dee57b.akpm@osdl.org> <42B22CD3.9080600@nortel.com> <20050616185754.3646511e.akpm@osdl.org> <Pine.LNX.4.61.0506171419570.10248@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0506171419570.10248@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> No need to check the list: any filesystem using simple_dir_operations
> is using dcache_readdir, which implies there's no storage to be synced.
> And we all agree that success is a more helpful retval than -EINVAL
> when there's nothing for fsync to do.  Here's a patch if you haven't
> done it already....

Thanks for the input.  I wasn't positive the change would be benign, so 
  I was waiting for the discussion to resolve itself.

Chris
