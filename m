Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUIOJKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUIOJKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUIOJFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:05:54 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:13085 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263962AbUIOJDc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:03:32 -0400
Message-ID: <41480542.9030305@zensonic.dk>
Date: Wed, 15 Sep 2004 11:02:58 +0200
From: "Thomas S. Iversen" <zensonic@zensonic.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Losing too many ticks! .... on a VIA epia board
References: <4146A09A.9010207@zensonic.dk> <41476812.7000401@zensonic.dk> <41480401.8030903@gmx.de>
In-Reply-To: <41480401.8030903@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:

> | Well, I made a kernel without acpi support and the problem went away.
> | Any clues to why that solved the problem?
>
> Frequency scaling or anything alike? Have you tried using acpi pm timer?
> This should prevent you from losing ticks.

Yeah, I found the acpi pm timer (a new option) and the problem went away.
I haven't got any frequency scaling included, so it's simply ACPI calls 
which
makes the system lose to many ticks :-(

Thomas

