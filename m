Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUHCWic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUHCWic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUHCWic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:38:32 -0400
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:58290
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S265232AbUHCWib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:38:31 -0400
Message-ID: <411013F7.7080800@tupshin.com>
Date: Tue, 03 Aug 2004 15:38:47 -0700
From: Tupshin Harper1 <tupshin@tupshin.com>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: /dev/hdl not showing up with 2.6.8-rc2-mm1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an x86 setup with a large(9) number of ide hard drives. With 
2.6.8-rc2, all of them show up (as a,b,d,e,f,g,h,i,j,k, and l), but on 
2.6.8-rc2-mm1, the last one (hdl) does not show up, even though it's a 
slave on the same controller as hdk. Everything about the config is 
identical between the two. Is there some default limit or other 
restriction in the current mm kernels that's preventing that drive from 
showing up? I haven't tried any other recent mm kernels, so I don't know 
when this was introduced.

-Tupshin
