Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTF3Q1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTF3Q1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:27:24 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:31978 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265163AbTF3Q1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:27:22 -0400
Message-ID: <3F00683A.3090506@nortelnetworks.com>
Date: Mon, 30 Jun 2003 12:41:30 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
References: <3EFFA1EA.7090502@nortelnetworks.com>	<16128.7306.58928.879567@cargo.ozlabs.ibm.com>	<3F004302.4070907@nortelnetworks.com> <20030630083725.25ffb48a.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen Hemminger wrote:

 > PPP did have problems keeping track of the tty until the latest round
 > if fixes (2.5.73+).  The ppp_async module wasn't using owner fields as
 > reqired.

bk-current as of last night still showed the same issues.

 >  Also, see if bringing down the ppp connection with ifconfig
 > before attempting the rmmod helps. i.e.
 > 	ifconfig ppp0 down

Will try.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

