Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267824AbUBRSoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUBRSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:44:05 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:11203 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267824AbUBRSoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:44:03 -0500
Message-ID: <4033B262.6060402@nortelnetworks.com>
Date: Wed, 18 Feb 2004 13:43:46 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ulrich Keil <ulrich@der-keiler.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New do_mremap vulnerabitily.
References: <20040218170827.GA93278@mail.der-keiler.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Keil wrote:
> There was also a Proof-of-concept exploit released:
> 
> http://www.derkeiler.com/Mailing-Lists/Securiteam/2004-02/0052.html

Its a bit confusing.  They talk about multiple instances of do_munmap() 
with unchecked return codes.  I can only find one, in move_vma().

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

