Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUCWLbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbUCWLbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:31:23 -0500
Received: from rootsrv.net ([217.160.131.12]:23193 "HELO rootsrv.net")
	by vger.kernel.org with SMTP id S262497AbUCWLao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:30:44 -0500
Message-ID: <40602018.4020202@pop2wap.net>
Date: Tue, 23 Mar 2004 12:31:36 +0100
From: Christof <mail@pop2wap.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: synchronous serial port communication (16550A)
References: <1CRaT-Zx-3@gated-at.bofh.it> <1CRO7-1s4-19@gated-at.bofh.it>
In-Reply-To: <1CRO7-1s4-19@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> Why don't you simply turn on hardware flow control (i.e. enable
> CRTSCTS with tcsetattr() or even stty) ?
> 
> Mike.

RTS has a special meaning with this lcd-controller, so I don't want that 
it is set without my implicit will.
