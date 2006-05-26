Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWEZEek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWEZEek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWEZEek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:34:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:58816 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030406AbWEZEej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:34:39 -0400
From: Neil Brown <neilb@suse.de>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Date: Fri, 26 May 2006 14:34:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17526.34136.986510.885941@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: why svc_export_lookup() has no implementation?
In-Reply-To: message from Xin Zhao on Friday May 26
References: <4ae3c140605252115n7b040a99l6633ba387ce48358@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 26, uszhaoxin@gmail.com wrote:
> I noticed that functions like exp_get_by_name() calls function
> svc_export_lookup(). But I cannot find the implementation of
> svc_export_lookup(). I can only find the function definition. HOw can
> this happen?
> 
> Can someone give me a hand?

Look at and understand DefineCacheLookup (in
include/linux/sunrpc/cache.h).

Then look for places that it is used.

But if you find you cannot stomach that, but assured that you aren't
alone and have a look in something newer than 2.6.16.  There-in, and
Randy has suggest, it will be easy to find the definition.

NeilBrown
