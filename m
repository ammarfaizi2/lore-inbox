Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUJGUuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUJGUuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUJGUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:37:25 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55543 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267958AbUJGUck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:32:40 -0400
Message-ID: <4165A7E4.30206@nortelnetworks.com>
Date: Thu, 07 Oct 2004 14:32:36 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on update_wall_time_one_tick() -- doh!
References: <4165A379.7030706@nortelnetworks.com>
In-Reply-To: <4165A379.7030706@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:

> Thus, doing an offset of +512000, immediately followed by an offset of 
> -512000, will leave you with a significant negative offset.
> 
> Is this the desired behaviour?

Just realized this was the old adjtime() behaviour.  Wasn't clear from the 
adjtimex() man page.

Chris
