Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135597AbRAUGpf>; Sun, 21 Jan 2001 01:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135460AbRAUGpZ>; Sun, 21 Jan 2001 01:45:25 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:52101 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S135597AbRAUGpQ>;
	Sun, 21 Jan 2001 01:45:16 -0500
Message-ID: <20010121144505.A17287@saw.sw.com.sg>
Date: Sun, 21 Jan 2001 14:45:05 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Kostas Nikoloudakis <kostas@corp124.com>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 error messages
In-Reply-To: <3A650B5B.EE1CCB07@corp124.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3A650B5B.EE1CCB07@corp124.com>; from "Kostas Nikoloudakis" on Tue, Jan 16, 2001 at 07:02:52PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 07:02:52PM -0800, Kostas Nikoloudakis wrote:
> Jan 16 00:49:04 cd20 kernel: eth0: card reports no resources. 
> Jan 16 00:49:06 cd20 kernel: eth0: can't fill rx buffer (force 0)! 

The driver can't allocate buffers for incoming packets.
Increase /proc/sys/vm/freepages numbers to start freeing the memory earlier
and reserve more memory for allocation bursts.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
