Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUJES1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUJES1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUJES1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:27:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46722 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261405AbUJES1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:27:40 -0400
Message-ID: <4162E754.9020905@sgi.com>
Date: Tue, 05 Oct 2004 13:26:28 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <200410042157.i94Lv7UC104750@fsgi900.americas.sgi.com> <20041005164842.A19754@infradead.org>
In-Reply-To: <20041005164842.A19754@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Oct 04, 2004 at 04:57:06PM -0500, Pat Gefre wrote:
> 
>>We have redone the I/O layer in the Altix code.
>>
>>We've broken the patch set down to 2 patches. One to remove the files,
>>the other to add in the new code. Most of the changes from the last
>>posting are in response to review comments.
> 
> 
> This looks pretty nice already, but a few small but important issues
> need sorting out.

>  - the patch reformats various unrelated or only slightly related files.
>    Please don't do that - in general the new style is better than the old
>    one, but it doesn't belong in this patchA

Guess I don't understand this. Either the code base is Lindent'd or it isn't.
