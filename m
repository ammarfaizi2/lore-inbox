Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUBRQua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUBRQsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:48:42 -0500
Received: from terminus.zytor.com ([63.209.29.3]:2693 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S266340AbUBRQsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:48:35 -0500
Message-ID: <4033974F.4090706@zytor.com>
Date: Wed, 18 Feb 2004 08:48:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
CC: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
References: <16434.58656.381712.241116@samba.org> <200402181105.58425.robin.rosenberg.lists@dewire.com> <16435.20457.610841.62521@samba.org> <200402181331.36859.robin.rosenberg.lists@dewire.com>
In-Reply-To: <200402181331.36859.robin.rosenberg.lists@dewire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
> 
> I believe (please correct me if this is wrong) that Windows never actually
> supported any of the UCS-2 code that were in conflict with UTF-16. The cost
> of this operation was that some of the "private" code blocks of unicode 2.0, i.e. 
> U+D800..U+DFFF were redefined as "surrogates" in Unicode 3.0 making the 
> UTF-16 encoding more or less backwards compatible with UCS-2. And it's 
> UTF-16LE and UCS-2LE, but I suspect you knew that :-)
> 

Make that Unicode 1.0 and 1.1, and you're correct.

	-hpa
