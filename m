Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIPUN>; Tue, 9 Jan 2001 10:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRAIPUE>; Tue, 9 Jan 2001 10:20:04 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:27400 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S129627AbRAIPT4>; Tue, 9 Jan 2001 10:19:56 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95139@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Stephen C. Tweedie'" <sct@redhat.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org
Subject: RE: Confirmation request about new 2.4.x. kernel limits
Date: Tue, 9 Jan 2001 10:15:34 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any memory over 1GB is bounce-buffered, but we don't use that memory
> for anything other than process data pages or file cache, so only
> swapping and disk IO to regular files gets the extra copy.  In
> particular, things like network buffers are still all kept in the low
> 1GB so never need to be buffered.
	[Venkatesh Ramamurthy]  If anything over 1GB is bounce buffered than
what is the purpose of setting the pci_dev->dma_mask field.  On a IA32
system we set it to 32 1's and IA64 to 64 1's - Venkat
>  
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
