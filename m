Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUANA7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUANA7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:59:15 -0500
Received: from [81.193.98.140] ([81.193.98.140]:2946 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S265117AbUANA7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:59:14 -0500
Message-ID: <400494FB.7040709@vgertech.com>
Date: Wed, 14 Jan 2004 01:01:47 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: ANother debugging Q
References: <200401131243.27614.gene.heskett@verizon.net> <20040113175638.GG20763@actcom.co.il> <200401131817.44856.gene.heskett@verizon.net>
In-Reply-To: <200401131817.44856.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Gene Heskett wrote:
> Unforch, that seems to shut down the opening of the error advisory 
> window.  It just sits there showing a blank (data wise) screen. And 
> extensive scrolling back thru about 5 megs of the output doesn't 
> disclose a missing file that I can see.  How would I go about 
> redirecting that output to grep, it seems to bypass an
> 
>  "strace -f ksysguard|grep open"
> 

Do "man strace" again :-)

Then see the -o option or the -e option.

(Or "man bash" and read about output redirection 2>&1 )

Regards,
Nuno Silva

