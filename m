Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVDFEGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVDFEGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 00:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVDFEGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 00:06:13 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9056 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262098AbVDFEGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 00:06:09 -0400
Date: Tue, 05 Apr 2005 22:05:19 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64 Machine hardlocks when using memset
In-reply-to: <3PxjH-812-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42535FFF.4080503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Ojst-4kX-19@gated-at.bofh.it> <3OGIo-7oY-13@gated-at.bofh.it>
 <3OGIo-7oY-15@gated-at.bofh.it> <3OGIo-7oY-17@gated-at.bofh.it>
 <3OGIo-7oY-11@gated-at.bofh.it> <3OIh7-cc-1@gated-at.bofh.it>
 <3OITV-AR-3@gated-at.bofh.it> <3PxjH-812-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2005-04-02 at 05:50, Robert Hancock wrote:
> 
>>I'm wondering if one does a ton of these cache-bypassing stores whether 
>>something gets hosed because of that. Not sure what that could be 
>>though. I don't imagine the chipset is involved with any of that on the 
>>Athlon 64 - either the CPU or RAM seems the most likely suspect to me
> 
> 
> The glibc version is essentially the "perfect" copy function for the
> CPU. If you have any bus/memory problems or chipset bugs it will bite
> you.

Anyone have any suggestions on how to track this further? It seems 
fairly clear what circumstances are causing it, but as for figuring out 
what's at fault..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

