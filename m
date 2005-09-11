Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVIKV47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVIKV47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVIKV47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:56:59 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:26038 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750926AbVIKV46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:56:58 -0400
X-ORBL: [69.107.86.160]
Message-ID: <4324A817.8050004@johana.com>
Date: Sun, 11 Sep 2005 14:56:39 -0700
From: Tom Watson <tsw@johana.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Pruning the source tree (idea)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In downloading the whole source tree for the 2.6 kernel, I note that 
there is quite a bit of code relating to architectures other than the 
one I'm using.  While this is a "good thing", it does take up space and if
I search for something in the kernel (grep, or some such), the non-used
architectures can take up additional time.

A proposal:
Have a top level make target that prunes (deletes summarily) the 
unwanted architectures from the source tree.  This should be able to be 
done before, or after a config step, but might not be allowed after the 
first make.  Of course, this step is optional, but for those of us who 
only have a single machine type, it would save a bunch of time.

Thanks

(non subscriber)
-- 
Tom Watson		Generic short signature
tsw@johana.com		I'm at home now.

