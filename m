Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUHCIoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUHCIoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHCIoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:44:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:26324 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265161AbUHCIom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:44:42 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OLS and console rearchitecture
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
	<410E55AA.8030709@ums.usu.ru> <celori$joe$1@news.cistron.nl>
	<je3c35qznz.fsf@sykes.suse.de>
	<1091468401.806.0.camel@localhost.localdomain>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..I just walked into th' HOUSE OF REPRESENTATIVES with fourteen WET
 DOLPHINS and an out-of-date MARRIAGE MANUAL...
Date: Tue, 03 Aug 2004 10:44:40 +0200
In-Reply-To: <1091468401.806.0.camel@localhost.localdomain> (Alan Cox's
 message of "Mon, 02 Aug 2004 18:40:02 +0100")
Message-ID: <jevfg0fw5j.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2004-08-02 at 17:21, Andreas Schwab wrote:
>> > A configuration file for killall5 in which services/daemons get
>> > defined that should not be signalled ?
>> 
>> IMHO a better solution would be some kind of process flag that can be
>> interrogated by killall5.
>
> Policy belongs in user space. This is entirely policy and personal
> preference.

The kernel would only function as a repository and makes sure the flag is
inherited across execve().  Any policy will only be set by user space.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
