Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVC3Ttn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVC3Ttn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVC3TtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:49:03 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10114 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262422AbVC3Tsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:48:50 -0500
Message-ID: <424B0420.7050109@tmr.com>
Date: Wed, 30 Mar 2005 14:55:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wiktor <victorjan@poczta.onet.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <4249B2B8.1090807@poczta.onet.pl>
In-Reply-To: <4249B2B8.1090807@poczta.onet.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor wrote:

> so i thought that it would be nice to add an attribute to file 
> (changable only for root) that would modify nice value of process when 
> it starts. if there is one byte free in ext2/3 file metadata, maybe it 
> could be used for that? i think that it woundn't be more dangerous than 
> setuid bit.

Given that setuid is possibly the most misused (no I didn't say 
overused) features around, that's hardly a recommendation. That said, 
have you looked at capabilities?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
