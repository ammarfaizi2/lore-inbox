Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275548AbRIZTnE>; Wed, 26 Sep 2001 15:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275546AbRIZTmx>; Wed, 26 Sep 2001 15:42:53 -0400
Received: from roc-24-169-99-201.rochester.rr.com ([24.169.99.201]:12275 "EHLO
	earth.netlinkaccess.com") by vger.kernel.org with ESMTP
	id <S275547AbRIZTmq>; Wed, 26 Sep 2001 15:42:46 -0400
Message-ID: <70D6465CE433D41187110001025FCF302413E6@mail.netlinkaccess.com>
From: Adam Kropelin <Adam.Kropelin@netlinkaccess.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'e2big@us.ibm.com'" <e2big@us.ibm.com>,
        "'jbarkal@us.ibm.com'" <jbarkal@us.ibm.com>
Subject: Re: Kernel text getting corrupted
Date: Wed, 26 Sep 2001 15:46:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, James Washer wrote:

> We've got a strange one. We're seeing system crashes where memory,
including 
> kernel text (executable) pages, is being corrupted. If you have any idea
what 
> might be causing this, or if you've seen this yourself, or if you have
ideas 
> on how to debug it, please let us know.

A number of these look like 1-bit-per-nibble corruptions, though that may
just be a coincidence. I'd run memtest86 for a while if I were you.

-- 
Adam Kropelin
NetLink Transaction Services, LLC.
