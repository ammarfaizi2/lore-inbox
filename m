Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWDKTz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWDKTz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWDKTz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:55:28 -0400
Received: from mailer2.psc.edu ([128.182.66.106]:62419 "EHLO mailer2.psc.edu")
	by vger.kernel.org with ESMTP id S1751348AbWDKTz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:55:27 -0400
Message-ID: <443C09A7.2040900@psc.edu>
Date: Tue, 11 Apr 2006 15:55:19 -0400
From: John Heffner <jheffner@psc.edu>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 regression: Very slow net transfer from some hosts
References: <443C03E6.7080202@gentoo.org> <443C024C.2070107@psc.edu> <443C0B74.50305@gentoo.org>
In-Reply-To: <443C0B74.50305@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> John Heffner wrote:
>> I'm not seeing this behavior myself.  What are the values of 
>> /proc/sys/net/ipv4/tcp_wmem, tcp_rmem, and tcp_mem?  How much memory 
>> does this system have?  (A binary tcpdump might be good, too.)
> 
> tcp_wmem: 4096    16384   131072
> tcp_rmem: 4096    87380   174760
> tcp_mem: 98304   131072  196608

These are (I assume) with the patch reversed.  What are the values with 
the patch applied?

Thanks,
   -John
