Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbTDNVA5 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263739AbTDNVAh (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:00:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263686AbTDNVA1 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:00:27 -0400
Message-ID: <3E9B242A.9080201@zytor.com>
Date: Mon, 14 Apr 2003 14:12:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
References: <002101c30239$fc0ae630$fe64a8c0@webserver> <8180000.1050330998@[10.10.2.4]> <20030414150759.GA14552@wind.cocodriloo.com> <11640000.1050332688@[10.10.2.4]> <b7etcd$s0n$1@cesium.transmeta.com> <3E9B1C8E.5030707@nortelnetworks.com>
In-Reply-To: <3E9B1C8E.5030707@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
>> munmap() and fsync() or msync() will flush it to disk; there is no reason
>> munmap() should unless perhaps the file was opened O_SYNC.
> 
> Wait a minute.  Shouldn't a file opened O_SYNC flush the writes as they
> happen,
> removing the requirement for any explicit syncing?  If it doesn't there
> are some very broken apps around.
> 

Not for mmap().

	-hpa


