Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTHUQVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTHUQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:21:42 -0400
Received: from main.gmane.org ([80.91.224.249]:19687 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262810AbTHUQVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:21:41 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Gecius <jens@gecius.de>
Subject: Re: 2.6.0-test3 smp irq balance
Date: Thu, 21 Aug 2003 18:21:39 +0200
Message-ID: <87vfsrq8vg.fsf@maniac.gecius.de>
References: <878yporqgy.fsf@maniac.gecius.de> <1061468471.27494.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
Cancel-Lock: sha1:AyMh4z0Ag+X8Ds3bmUbhfIWoAls=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

>> irqs seem not to be distributed between cpus, having one to handle all
>> (even while building kernel on both cpus (according to gkrell), the
>> numbers for the second cpu don't change.
>
> just install and run the irqbalance daemon from:
> http://people.redhat.com/arjanv/irqbalance

I did. Didn't change anything. The numbers are the same - the only
CPU2 irq increasing is LOC. Any other hints?

-- 
Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
 Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 A89B 28D0 F097

