Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUHDULl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUHDULl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267402AbUHDULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:11:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:7137 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267404AbUHDUL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:11:29 -0400
Date: Wed, 04 Aug 2004 13:09:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: axboe@suse.de, eric@cisu.net, kernel@kolivas.org, barryn@pobox.com,
       swsnyder@insightbb.com, linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-ID: <213080000.1091650198@flay>
In-Reply-To: <20040804125129.704ba13a.akpm@osdl.org>
References: <200408021602.34320.swsnyder@insightbb.com><410FA145.70701@kolivas.org><20040804060625.GE10340@suse.de><200408040614.30820.eric@cisu.net><20040804130707.GN10340@suse.de><20040804120633.4dca57b3.akpm@osdl.org><210450000.1091647829@flay> <20040804125129.704ba13a.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, August 04, 2004 12:51:29 -0700 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> I had a patch for a config option, ported forward by someone at IBM (I forget
>>  who, possibly Dave) from Andrea's original. I think we finally decided 
>>  (in consultation with Andrea) we could drop the complicated stuff he had
>>  in the asm code, so it's pretty simple ... something like this:
> 
> I sent such a patch to the boss many moons ago and he said "go away, this
> is a vendor-only thing". 

Yeah, I know. But then he hates 4/4 split even more, and going to 2/2 is
a trivial way to solve the 64GB machines ;-)

Maybe I should embed it in an ioctl patch for a mouse driver?
/me runs like hell.

M.

