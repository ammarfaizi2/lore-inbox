Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310524AbSCKRxW>; Mon, 11 Mar 2002 12:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310525AbSCKRxM>; Mon, 11 Mar 2002 12:53:12 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:3070 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S310524AbSCKRxG>; Mon, 11 Mar 2002 12:53:06 -0500
Message-ID: <3C8CEEFC.8137F5C0@redhat.com>
Date: Mon, 11 Mar 2002 17:53:00 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kRZp-0000or-00@the-village.bc.nu> <3C8CDA0D.7020703@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And apparently we see that there is nothing special about them... Just don't
> enable the write cache and all should be well with a timeout of 30 seconds.

Quite a few controllers enable the write cache in their bootstrap before
the OS gets involved.
Just "don't enable" is not an option.
