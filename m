Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUIXV1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUIXV1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUIXV1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:27:37 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:27584 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S268899AbUIXV12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:27:28 -0400
Message-ID: <41549120.2060509@zytor.com>
Date: Fri, 24 Sep 2004 14:26:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       davej@codemonkey.org.uk
Subject: Re: [PATCH 2.6.9-rc2-mm2] Create new function to see if pci dev is
 present
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com> <20040924200231.A30391@infradead.org> <20040924211912.GC7619@kroah.com>
In-Reply-To: <20040924211912.GC7619@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> Good idea, but do you see any places in the kernel that would use those
> fields, instead of always setting them to PCI_ANY_ID?
> 

Does it matter what it is currently used for?  It *is* one way you can find 
out about specific board bugs.  I'd think you'd want all of (VID, DID, RID, 
SVID, SID).


	-hpa
