Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289834AbSBOPaz>; Fri, 15 Feb 2002 10:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289858AbSBOPaq>; Fri, 15 Feb 2002 10:30:46 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:10441 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289834AbSBOPaa>; Fri, 15 Feb 2002 10:30:30 -0500
Message-ID: <3C6D2994.55C1A4A3@redhat.com>
Date: Fri, 15 Feb 2002 15:30:28 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Jameson <rj@open-net.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.18-pre9-mjc2
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org> <1013780277.950.663.camel@phantasy> <20020215102037.00cf2ad9.rj@open-net.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jameson wrote:
> 
> It's appears right after my PDA finishes syncing, so im guessing, its
> during a device close. To answer alans question im using nVidias kernel
> driver, therefor i tainted the kernel (tm) (c).

you're using a binary only kernel driver AND a preempt kernel ?
brave. very brave.

preempt works on the assumption that it can change the content of inline
functions and such....
