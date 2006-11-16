Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424622AbWKPVNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424622AbWKPVNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424631AbWKPVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:13:18 -0500
Received: from hera.kernel.org ([140.211.167.34]:15316 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1424622AbWKPVNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:13:17 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: changing internal kernel system mechanism in runtime by a
 module patch
Date: Thu, 16 Nov 2006 13:12:43 -0800
Organization: OSDL
Message-ID: <20061116131243.1f4d6ccd@freekitty>
References: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1163711564 21182 10.8.0.54 (16 Nov 2006 21:12:44 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 16 Nov 2006 21:12:44 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 21:19:50 +0200
"Yitzchak Eidus" <ieidus@gmail.com> wrote:

> is it possible to replace linux kernel internal functions such as
> schdule () to lets say my_schdule ()  in a run time with a module
> patch???
> (so that every call in the kernel to schdule() will go to my_schdule()... ) ???
> 
> i am talking about a clean/standard way to do such thing
> (without overwrite the mem address of the function and replace it in a
> dirty way...)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Look at kprobe/jprobe.

-- 
Stephen Hemminger <shemminger@osdl.org>
