Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVAQGrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVAQGrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 01:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVAQGrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 01:47:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22449 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262713AbVAQGrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 01:47:06 -0500
Date: Mon, 17 Jan 2005 12:19:42 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: karim@opersys.com
Cc: trz@us.ibm.com, ak@muc.de, maneesh@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050117064942.GC16105@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim,

> Thomas Gleixner wrote:
>> It's not only me, who needs constant time. Everybody interested in
>> tracing will need that. In my opinion its a principle of tracing.
> 
> relayfs is a generalized buffering mechanism. Tracing is one application
> it serves. Check out the web site: "high-speed data-relay filesystem."
> Fancy name huh ...
> 
>> The "lockless" mechanism is _FAKE_ as I already pointed out. It replaces
>> locks by do { } while loops. So what ?
> 

How about combining "buffering mechansim of relayfs" and
"kernel-> user space tranport by debugfs"
This will also remove lots of compilcated code from realyfs.

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
