Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVG2AAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVG2AAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVG2AAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:00:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26352 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262160AbVG2AAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:00:37 -0400
Message-ID: <42E97133.8060307@mvista.com>
Date: Thu, 28 Jul 2005 16:58:43 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watch dog notify patch
References: <42E940BE.3020908@mvista.com> <20050728161341.15bf9625.akpm@osdl.org>
In-Reply-To: <20050728161341.15bf9625.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>>	This patch adds a notify to the nmi watchdog to notify that
>> 	the system is about to be taken down by the watchdog.  If the
>> 	notify is handled with a NOTIFY_STOP return, the system is
>> 	given a new lease on life.
> 
> 
> It looks sensible, but as there aren't actually any in-kernel uses for this
> I'd have thought it would be better for it to live out-of-tree?

I should just bundle it with the kgdb patch then?
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
