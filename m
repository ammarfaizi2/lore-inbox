Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUBDSm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUBDSm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:42:29 -0500
Received: from yipvma-ext.prodigy.net ([207.115.63.28]:2973 "EHLO
	yipvma.prodigy.net") by vger.kernel.org with ESMTP id S263942AbUBDSm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:42:28 -0500
Message-ID: <40213CFD.5090802@matchmail.com>
Date: Wed, 04 Feb 2004 10:42:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4's sys_readahead is borked
References: <1075853962.8022.3.camel@localhost>	 <Pine.LNX.4.58L.0402041224050.1700@logos.cnet> <1075908048.11309.6.camel@localhost>
In-Reply-To: <1075908048.11309.6.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Wed, 2004-02-04 at 12:30 -0200, Marcelo Tosatti wrote:
>>Question: Do you know any user of sys_readahead() ?
> 
> 
> Not really - I've been playing with it.  But OpenOffice just added it to
> preload some of their libraries.  It should probably be deprecated and
> remove in 2.7, since posix_fadvise(POSIX_FADV_WILLNEED) does this same
> thing.

In 2.4 also?
