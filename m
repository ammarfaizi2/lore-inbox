Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVFBABD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVFBABD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFAX75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:59:57 -0400
Received: from mail.tmr.com ([64.65.253.246]:902 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261499AbVFAX5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:57:54 -0400
Message-ID: <429E4B7C.9080003@tmr.com>
Date: Wed, 01 Jun 2005 19:57:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cutaway@bellsouth.net
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com> <20050601192934.GP20782@holomorphy.com> <429E10B9.601@tmr.com> <002501c566f7$7ed2b2e0$2800000a@pc365dualp2>
In-Reply-To: <002501c566f7$7ed2b2e0$2800000a@pc365dualp2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cutaway@bellsouth.net wrote:

>----- Original Message ----- 
>From: "Bill Davidsen" <davidsen@tmr.com>
>To: "William Lee Irwin III" <wli@holomorphy.com>
>Cc: <linux-kernel@vger.kernel.org>
>Sent: Wednesday, June 01, 2005 15:47
>Subject: Re: Swap maximum size documented ?
>
>
>  
>
>>>>Does this apply to mmap as well? I have an application which currently
>>>>uses 9TB of data....
>>>>        
>>>>
>
>With this much data, you might consider investigating its compressability.
>If it turned out to be highly compressable, algorithmic changes in how the
>data is handled might considerably lighten the load on MM and disk
>subsystems.  Its almost always cheaper to compress/decompress cached data in
>memory than hit physical media.
>

The majority of the records are compressed as of about a decade ago.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

