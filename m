Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUJEUPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUJEUPC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUJEUPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:15:02 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:54756 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263962AbUJEUNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:13:25 -0400
Message-ID: <4163005B.2090000@t-online.de>
Date: Tue, 05 Oct 2004 22:13:15 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041002 Debian/1.7.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Jellinghaus <aj@dungeon.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: block till hotplug is done?
References: <1097005927.4953.4.camel@simulacron>
In-Reply-To: <1097005927.4953.4.camel@simulacron>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: E1vTbTZvZe+DLFzg0s8UvoQorZcwAitsqM4dvsbe6Z4w4wfvn5iu8V
X-TOI-MSGID: 1dfbf80c-74de-461d-b5c3-c632e9e54d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus wrote:
> Hi,
> 
> is there any way to block till all hotplug events are handled/
> the hotplug processes terminated?
> 

while [ "`ps | grep /sbin/hotplug | grep -v grep`" ]; do sleep 1; done

?


Regards

Harri
