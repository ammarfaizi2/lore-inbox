Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbUKAMqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUKAMqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbUKAMn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:43:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3748 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261773AbUKAMjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:39:09 -0500
Message-ID: <41862E5F.60300@redhat.com>
Date: Mon, 01 Nov 2004 07:38:55 -0500
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ych43 <ych43@student.canterbury.ac.nz>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP port numbers
References: <41838517@webmail>
In-Reply-To: <41838517@webmail>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ych43 wrote:
> Hi,
>  I got one question about unix socket functions. I have two machines (called A 
> and B). I use A to telnet B, get the root password of B. Is there any unix 
> socket function I can use to get the port number of A on B. Obviously, the 
> port number of B is 23. I want to use a socket function implemented on B to 
> get the port number of A because a TCP connection is established between them.
>   I greatly appreciate it if you help me. Thank you in advance.
>   Xue
> 
I think getpeername is the library call you are looking for
HTH
Neil
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
