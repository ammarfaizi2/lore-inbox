Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUCKT1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCKT1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:27:33 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:23189 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261674AbUCKTZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:25:31 -0500
Message-ID: <4050BD27.9040502@matchmail.com>
Date: Thu, 11 Mar 2004 11:25:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jlnance@unity.ncsu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311134017.GA2813@ncsu.edu>
In-Reply-To: <20040311134017.GA2813@ncsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
> On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
> 
>>  This affects I/O scheduling potentially quite significantly.  It is no
>>  longer the case that the kernel will submit pages for I/O in the order in
>>  which the application dirtied them.  We instead submit them in file-offset
>>  order all the time.
> 
> 
> Hi Andrew,
>     I have a feeling this change might significantly improve the external
> sorting benchmark I emailed you ( http://lkml.org/lkml/2003/12/20/46 ).
> I will try running it when I get a chance and let you know.  It gives me
> a good excuse to get 2.6 kernels working on my systems :-)

Hmm, what is happening with Roger Luethi's work lately?

Have there been any patches for use once in this case?
