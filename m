Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUFQWfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUFQWfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUFQWfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:35:20 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:55502 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S264067AbUFQWfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:35:03 -0400
Message-ID: <40D21C8E.4040500@candelatech.com>
Date: Thu, 17 Jun 2004 15:34:54 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll
References: <Pine.LNX.4.53.0406170954190.702@chaos>
In-Reply-To: <Pine.LNX.4.53.0406170954190.702@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Hello,
> Is it okay to use the 'extra' bits in the poll return value for
> something? In other words, is the kernel going to allow a user-space
> program to define some poll-bits that it waits for, these bits
> having been used in the driver?

Can't you just do a read and determine from the results of the read
what you actually got?  If not, add framing to your message so that
you *CAN* determine one message type from another...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

