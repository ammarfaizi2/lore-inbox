Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUJHTVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUJHTVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUJHTSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 15:18:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29115 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261610AbUJHTRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 15:17:36 -0400
Message-ID: <4166E7CC.4060207@redhat.com>
Date: Fri, 08 Oct 2004 15:17:32 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: shankar krishnamurthy <kshan_77@yahoo.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: character device interface to existing socket interface.
References: <20041008181354.75169.qmail@web52306.mail.yahoo.com>
In-Reply-To: <20041008181354.75169.qmail@web52306.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shankar krishnamurthy wrote:
> I am looking for help in writing character 
> device interface for existing socket interface.
> 
> Planning to write as kernel module. Kernel 2.4.20. 
> It will be a simple pass through to the socket. I mean
> it sits above socket and whatever user gives, the 
> driver passes it to socket and vice versa. In that
> sense its pass-through or a psuedo driver.
> 
> When user creates the device, he gives already 
> connected socket to device driver. Once device
> gets created, user closes the socket!
> 
> My hunch is that this looks so common that somebody
> would have already written or have some pointer to it.
> 
> Somebody may wonder why one needs this ...but for
> we can take it as *application specific* requirement.
> 
> Please let me know if you know anything about it.
> 
> 
> 		
> __________________________________
> Do you Yahoo!?
> Read only the mail you want - Yahoo! Mail SpamGuard.
> http://promotions.yahoo.com/new_mail 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Something pretty close has already been done in the driver for 
/dev/inet/[tcp|udp|icmp|etc].
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
