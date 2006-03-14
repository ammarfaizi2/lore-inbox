Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWCNJ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWCNJ1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWCNJ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:27:42 -0500
Received: from mail.dvmed.net ([216.237.124.58]:27816 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751875AbWCNJ1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:27:41 -0500
Message-ID: <44168C86.8060107@garzik.org>
Date: Tue, 14 Mar 2006 04:27:34 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ed Lin <ed.lin@promise.com>, Andrew Morton <akpm@osdl.org>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "promise_linux@promise.com" <promise_linux@promise.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
References: <NONAMEBgJJ72jYxDwLd000000d3@nonameb.ptu.promise.com> <1142327906.3027.24.camel@laptopd505.fenrus.org>
In-Reply-To: <1142327906.3027.24.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>>>+struct st_sgitem {
>>>>+struct st_sgtable {
>>>>+struct handshake_frame {
>>>>+struct req_msg {
>>>>+struct status_msg {
>>>
>>>Has this all been tested on big-endian hardware?
>>>
>>
>>No. It was only tested on i386 and x86-64 machines.
> 
> 
> you'll want those to be __attribute__((packed)) as well btw

I thought that was unnecessary if the struct members are ordered such 
that compiler would not add padding?

	Jeff



