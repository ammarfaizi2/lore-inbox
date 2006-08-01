Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWHARAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWHARAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWHARAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:00:23 -0400
Received: from mail.tmr.com ([64.65.253.246]:57828 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751481AbWHARAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:00:22 -0400
Message-ID: <44CF8C2D.2010900@tmr.com>
Date: Tue, 01 Aug 2006 13:15:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 9] md: Factor out part of raid10d into a separate
 function.
References: <20060731172842.24323.patches@notabene> <1060731073208.24470@suse.de>
In-Reply-To: <1060731073208.24470@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don't think this is better, NeilBrown wrote:

>raid10d has toooo many nested block, so take the fix_read_error
>functionality out into a separate function.
>  
>

Definite improvement in readability. Will all versions of the compiler 
do something appropriate WRT inlining or not?

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

