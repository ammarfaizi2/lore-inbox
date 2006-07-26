Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWGZOOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGZOOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWGZOOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:14:39 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:32531 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750728AbWGZOOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:14:38 -0400
Message-ID: <44C778CA.1010404@argo.co.il>
Date: Wed, 26 Jul 2006 17:14:34 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: hch@infradead.org, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org,
       drepper@redhat.com, netdev@vger.kernel.org
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
References: <20060726.031247.98341392.davem@davemloft.net>
In-Reply-To: <20060726.031247.98341392.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jul 2006 14:14:36.0593 (UTC) FILETIME=[D33CEA10:01C6B0BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
>
> From: Christoph Hellwig <hch@infradead.org>
> Date: Wed, 26 Jul 2006 11:04:31 +0100
>
> > And to be honest, I don't think adding all this code is acceptable
> > if it can't replace the existing aio code while keeping the
> > interface.  So while you interface looks pretty sane the
> > implementation needs a lot of work still :)
>
> Networking and disk AIO have significantly different needs.
>
Surely, there needs to be a unified polling interface to support single 
threaded designs.

-- 
error compiling committee.c: too many arguments to function

