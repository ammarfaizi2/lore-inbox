Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKTQB6>; Mon, 20 Nov 2000 11:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKTQBu>; Mon, 20 Nov 2000 11:01:50 -0500
Received: from ext.lri.fr ([129.175.15.4]:61641 "EHLO ext.lri.fr")
	by vger.kernel.org with ESMTP id <S129136AbQKTQBb>;
	Mon, 20 Nov 2000 11:01:31 -0500
From: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <14873.17358.536711.2282@sun-demons>
Date: Mon, 20 Nov 2000 16:31:26 +0100 (MET)
To: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <3A15CE34.EF2FE3CC@uow.edu.au>
In-Reply-To: <14868.3329.775330.576681@sun-demons>
	<3A15CE34.EF2FE3CC@uow.edu.au>
X-Mailer: VM 6.62 under Emacs 20.7.1
Reply-To: Benjamin.Monate@lri.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In his message of Sat 18 November, Andrew Morton writes : 
> Try booting with the `noapic' option.  Looks like your APIC
> is getting itself unprogrammed.  Check that you're not
> overclocked and not over temperature.

Booting with noapic did not improve anything.
The processor is not supposed to be overclocked. How can I be sure of
that ?

Further investigations showed that the problem will occur only when
Xfree 4.0.1 is running with an smp kenel . Xfree 3.3.6 is ok. Could this
be a bug in X ?  I thought that the kernel should prevent such a bug
from locking the computer.

Thank you again for your help.
-- 
| Benjamin Monate         | mailto:Benjamin.Monate@lri.fr |
| LRI - Bât. 490
| Université de Paris-Sud | phoneto: +33 1 69 15 42 32    |
| F-91405 ORSAY Cedex     | faxto: +33 1 69 15 65 86      |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
