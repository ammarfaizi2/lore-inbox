Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVHJUzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVHJUzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVHJUzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:55:05 -0400
Received: from mail734.megamailservers.com ([69.49.98.44]:9355 "EHLO
	mail734.megamailservers.com") by vger.kernel.org with ESMTP
	id S1030264AbVHJUzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:55:02 -0400
X-Authenticated-User: paulkf.microgate.com
Message-ID: <42FA692B.4030406@microgate.com>
Date: Wed, 10 Aug 2005 15:52:59 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: CCITT-CRC16 in kernel
References: <Pine.LNX.4.61.0508101549280.10525@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508101549280.10525@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

>the CCIT-16 CRC. I note that drivers that use it expect it
>to return 0xf0b8 if it performs the CRC of something that
>has the CRC appended (weird).
>

That is the remainder you get when checking
a received CRC for correctness. If the value
is not 0xf0b8, there is an error in the block.

--
Paul Fulghum
Microgate Systems, Ltd
