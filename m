Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288250AbSAHTPb>; Tue, 8 Jan 2002 14:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAHTPV>; Tue, 8 Jan 2002 14:15:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:1474 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288250AbSAHTPM>;
	Tue, 8 Jan 2002 14:15:12 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15419.17727.546185.257524@napali.hpl.hp.com>
Date: Tue, 8 Jan 2002 19:15:11 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: [Linux-ia64] Re: can we make anonymous memory non-EXECUTABLE?
In-Reply-To: <E16NwDj-0006LP-00@the-village.bc.nu>
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com>
	<E16NwDj-0006LP-00@the-village.bc.nu>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 8 Jan 2002 13:23:15 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> We are borg of x86 is true for the near future, but codifying
  Alan> an x86ism for all ports for ever seems unwise.

Glad to hear that.

  Alan> For IA32 on IA64 binaries you would however need to keep the
  Alan> executable data behaviour.

Yes.  I don't recall off hand whether the x86 emulation hardware (aka
"IVE") automatically takes care of that.  I'll work on prototyping
this.

Thanks,

	--david
