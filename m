Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVKWRuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVKWRuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVKWRuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:50:00 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:58937 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932089AbVKWRt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:49:58 -0500
Message-ID: <4384A84B.5080709@tmr.com>
Date: Wed, 23 Nov 2005 12:35:07 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: moreau francis <francis_moreau2000@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>	 <200511231631.12365.vda@ilport.com.ua> <1132758910.7268.32.camel@localhost.localdomain>
In-Reply-To: <1132758910.7268.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2005-11-23 at 16:31 +0200, Denis Vlasenko wrote:
> 
>>Enums are really nice substitute for integer constants instead of #defines.
>>Enums obey scope rules, #defines do not.
>>
>>However enums are not widely used because of
>>1. tradition and style
>>2. awkward syntax required:   enum { ABC = 123 };
> 
> 
> The SATA layer uses enum for constants and while it was a bit of change
> in style when I met it, it does seem to work just as well
> 

Well, perhaps better, since there is some type checking, and where 
auto-increment can be used finger checks don't generate duplicate values 
or undefined holes in the value set.

Like the struct definitions vs. old K&R definitions, there is a mental 
style adjustment to be made.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

