Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUJEVsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUJEVsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUJEVsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:48:24 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54401 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266127AbUJEVsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:48:21 -0400
Message-ID: <41631698.5080301@comcast.net>
Date: Tue, 05 Oct 2004 17:48:08 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
References: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johnson, Richard wrote:
> 
SNIP
> 
> make oldconfig
> make bzImage
> make modules
> make modules_install
> 
> This seemed to go alright. Then I entered:
> 
> make install
> 
> This had some warning about module versions, but it seemed to work.

Doesn't anyone do the following anymore:

make mrproper
make oldconfig
make bzImage
make modules
make modules_install

I've seen a lot of problems come from NOT running the mrproper.

Regards,
David
