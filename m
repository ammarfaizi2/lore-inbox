Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVKPFyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVKPFyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVKPFyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:54:50 -0500
Received: from fmr19.intel.com ([134.134.136.18]:22221 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932586AbVKPFyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:54:49 -0500
Subject: Re: Linuv 2.6.15-rc1
From: Zhu Yi <yi.zhu@intel.com>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
In-Reply-To: <20051115140023.GB9910@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org>
	 <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt>
	 <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
	 <20051115140023.GB9910@gemtek.lt>
Content-Type: text/plain
Organization: Intel Corp.
Date: Wed, 16 Nov 2005 13:49:04 +0800
Message-Id: <1132120145.18679.12.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 16:00 +0200, Zilvinas Valinskas wrote:
> Hello again,
> 
> screenshots of ooops (not of the best quality though :( ) - 
> http://www.gemtek.lt/~zilvinas/dumps/  - as it can be seen from
> screenshots crashing in _ipw_read_indirect_0xa9/0x179 ... This time it
> took a while to reproduce a problem. Somehow I get impression it is
> either f/w loading related (see attached oops.1 file) and/or initiating
> scan and reading back wireless scan results ??? ...

Please try the patch below and see if it makes any difference.
http://bughost.org/bugzilla/show_bug.cgi?id=821

Thanks,
-yi

