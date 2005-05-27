Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVE0PZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVE0PZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVE0PZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:25:40 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:31182 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261813AbVE0PZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:25:35 -0400
Message-ID: <42973C1B.2060101@vc.cvut.cz>
Date: Fri, 27 May 2005 17:26:19 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Gabor MICSKO <gmicsko@szintezis.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc2 - 2.6.12-rc5] oops with vmware
References: <1117206120.1954.7.camel@alderaan.trey.hu>
In-Reply-To: <1117206120.1954.7.camel@alderaan.trey.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor MICSKO wrote:
> Hi!
> 
> I have a problem with running vmware on between 2.6.12-rc2 and
> 2.6.12-rc5 kernels. I have no problem with 2.6.12-rc1.

Warnings printed while building vmnet module are important, you should
not have ignored them.  You need vmware-any-any-update90, one
of API function changed its signature, but not sufficiently so thing
still builds (with warnings), but crashes at runtime.
							Petr Vandrovec

