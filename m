Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTABGBw>; Thu, 2 Jan 2003 01:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbTABGBw>; Thu, 2 Jan 2003 01:01:52 -0500
Received: from main.gmane.org ([80.91.224.249]:61074 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265708AbTABGBv>;
	Thu, 2 Jan 2003 01:01:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Andres Salomon" <dilinger@voxel.net>
Subject: Re: [PATCH] Re: Linux v2.5.54 - OHCI-HCD build fails
Date: Thu, 02 Jan 2003 01:10:18 -0500
Message-ID: <pan.2003.01.02.06.10.17.649495@voxel.net>
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com> <20030102045245.GA1464@Master.Wizards> <20030102050007.GB1464@Master.Wizards> <pan.2003.01.02.05.16.23.282892@voxel.net> <20030102054337.GA1418@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack.  I need to start using some proper revision control for kernel stuff.

:/


On Thu, 02 Jan 2003 00:43:37 -0500, Murray J. Root wrote:

> On Thu, Jan 02, 2003 at 12:16:33AM -0500, Andres Salomon wrote:
>> This fixes it.  data0 and data1 are defined inside a DEBUG #ifdef context,
>> and used outside of it.
>>  
> 
> Um - the patch is backwards.
> The lines already existed at 218 & 219. Moving em up to 9 solved the problem
> Thanks for the hint.



