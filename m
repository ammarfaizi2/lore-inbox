Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUGFDbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUGFDbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 23:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGFDbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 23:31:36 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:20119 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262905AbUGFDbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 23:31:35 -0400
Message-ID: <40EA1D14.6070100@myrealbox.com>
Date: Mon, 05 Jul 2004 20:31:32 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@infradead.org, linux-kernel@vger.kernel.org,
       olaf+list.linux-kernel@olafdietsche.de,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: procfs permissions on 2.6.x
References: <20040703202242.GA31656@MAIL.13thfloor.at>	<20040703202541.GA11398@infradead.org>	<20040703133556.44b70d60.akpm@osdl.org>	<20040703210407.GA11773@infradead.org>	<20040703143558.5f2c06d6.akpm@osdl.org>	<20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk>	<20040704145542.4d1723f5.akpm@osdl.org>	<20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk> <20040704154303.4eb0fbaf.akpm@osdl.org>
In-Reply-To: <20040704154303.4eb0fbaf.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>Why on the earth do we ever want to allow chown/chmod on procfs in the first
>>place?

[...]

> 
> As for why anyone would _want_ to change these things: no idea.

Because I don't want the whole world reading my conntrack state.  And 
I'm sure other people have other opinions there and on other things, so 
that's why we should be able to change it.

--Andy

