Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269810AbUHZXsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269810AbUHZXsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbUHZXpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:45:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:22665 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269702AbUHZXoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:44:17 -0400
Date: Thu, 26 Aug 2004 16:43:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <76370000.1093563781@flay>
In-Reply-To: <412E7004.3070503@kolivas.org>
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl> <412E11ED.7040300@kolivas.org> <52540000.1093553736@flay> <412E7004.3070503@kolivas.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, August 27, 2004 09:19:32 +1000 Con Kolivas <kernel@kolivas.org> wrote:

> Martin J. Bligh wrote:
>> --On Friday, August 27, 2004 02:38:05 +1000 Con Kolivas <kernel@kolivas.org> wrote:
>>> Rafael J. Wysocki wrote:
>>>> Actually, with the current scheduler, updatedb really sucks.  It's supposed to 
>>>> be a background task, but it hogs IO resources and memory like crazy 
>>>> (disclaimer: it's my personal subjective observation).
>>> 
>>> The cpu scheduler plays almost no part in this. It's the I/O scheduler and the vm. IOnice will help the former _when it comes out_. Dropping the swappiness kind of helps the latter; although there are numerous alternative tweaks appearing for that too.
>> 
>> Yup. I can open a large 8Mpixel camera image in "display" and hang the whole
>> system for about 30s too ;-(
> 
> If you're talking about using the embedded image viewer in kde, that spins on wait and wastes truckloads of cpu (a perfect example of poor coding). Try loading it an external viewer and it will be 1000 times faster. If you're talking about it keeping the disk too busy on the other hand, that's I/O scheduling.

Nope, I'm talking about the app "display", which I think is part of
ImageMagick or soemthing.

M.

