Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUDNNcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUDNNcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:32:50 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:54268 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264223AbUDNNcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:32:36 -0400
Message-ID: <407D3D46.9010403@nortelnetworks.com>
Date: Wed, 14 Apr 2004 09:31:50 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
References: <407CEB91.1080503@pobox.com> <20040414005832.083de325.akpm@osdl.org> <20040414010240.0e9f4115.akpm@osdl.org> <407CF201.408@pobox.com> <20040414082716.GA25439@hockin.org> <407CFAD7.4070606@pobox.com>
In-Reply-To: <407CFAD7.4070606@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tim Hockin wrote:
> 
>> Somewhat off the original topic, but am I the only one who finds it weird
>> (and error-prone) that you have to add the same KConfig to a dozen or 
>> more
>> Kconfig files?
>>
>> Shouldn't there be a KConfig libe, and all you need to do for the arch is
>> reference the CONFIG_FOO from the lib?  Would at least save all the
>> duplicate strings and definitions...

> Seems a lot easier just to gather the common definitions into a Kconfig 
> file, and include it via the standard 'source' directive.

Either way, I personally would be extremely grateful for some kind of 
standard way to add a new configurable generic feature to every 
architecture.  I'm tired of having to add it manually.  I hadn't 
realized about the "source" feature--seems like we should be able to 
pull a lot of stuff into something like that even now.

On a side note, why is there no Kconfig for the "kernel" directory?

Chris
