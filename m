Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbVK3S5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbVK3S5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 13:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVK3S5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 13:57:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:11188 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751507AbVK3S5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 13:57:01 -0500
Subject: Better pagecache statistics ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 10:57:09 -0800
Message-Id: <1133377029.27824.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a effort/patches underway to provide better pagecache
statistics ? 

Basically, I am interested in finding detailed break out of
cached pages. ("Cached" in /proc/meminfo) 

Out of this "cached pages"

- How much is just file system cache (regular file data) ?
- How much is shared memory pages ?
- How much is mmaped() stuff ?
- How much is for text, data, bss, heap, malloc ?

What is the right way of getting this kind of data ? 
I was trying to add tags when we do add_to_page_cache()
and quickly got ugly :(

Thanks,
Badari

