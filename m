Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbRGWIfZ>; Mon, 23 Jul 2001 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbRGWIfP>; Mon, 23 Jul 2001 04:35:15 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:65486 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S268148AbRGWIfK>; Mon, 23 Jul 2001 04:35:10 -0400
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: Jonathan Picht <jonathan.picht@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: loopback mount doesn't work with files on shm filesystem
In-Reply-To: <20010722223354.A10830@lithium.localdomain>
Organisation: SAP LinuxLab
In-Reply-To: <20010722223354.A10830@lithium.localdomain>
Message-ID: <m3ae1w9kdi.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 23 Jul 2001 10:31:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Jonathan,

On Sun, 22 Jul 2001, Jonathan Picht wrote:
> Hello,
> 
> if I try to mount a file which resides on shm with '-o loop',
> I get this output:
> 
> ioctl: LOOP_SET_FD: Invalid argument

Yes, loopback does not work on tmpfs and is not easy to implement.

Greetings
		Christoph


