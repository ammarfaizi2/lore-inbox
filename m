Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292820AbSCELia>; Tue, 5 Mar 2002 06:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292817AbSCELiQ>; Tue, 5 Mar 2002 06:38:16 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:31473 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S292806AbSCELh7>; Tue, 5 Mar 2002 06:37:59 -0500
Message-ID: <3C84AE16.A7F1ECCA@redhat.com>
Date: Tue, 05 Mar 2002 11:37:58 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16i9mc-00043p-00@wagner.rustcorp.com.au> <3C84A34E.6060708@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> - Disable configuration of the task file stuff. It is going to go away
>    and will be replaced by a truly abstract interface based on
>    functionality and *not* direct mess-up of hardware.

Can we also expect a patch to remove the scb's from the scsi midlayer
from you ?
I mean, if a standard specifies a nice *common* command packet format
I'd expect the midlayer
to create such packets. Taskfile is exactly that... why removing it ?
