Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbTGACMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 22:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265852AbTGACMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 22:12:42 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:48784 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265882AbTGACMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 22:12:01 -0400
Message-ID: <3F00F149.7000302@nortelnetworks.com>
Date: Mon, 30 Jun 2003 22:26:17 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
References: <3EFFA1EA.7090502@nortelnetworks.com> <16128.7306.58928.879567@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

> Is this the user-mode pppoe or the in-kernel pppoe?  IOW, are you
> using the pppoe channel type, or do you have the usermode program that
> runs pppd behind a pty?

Usermode, roaring penguin pppoe, version 3.5.

> And, do you have any TCP connections open over the link when you take
> it down?  What version of pppd is it?

On at least some occasions, no connections open.  pppd version 2.4.1

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

