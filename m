Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWJUXl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWJUXl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 19:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161500AbWJUXl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 19:41:59 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:15586 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1161160AbWJUXl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 19:41:58 -0400
Date: Sun, 22 Oct 2006 01:41:07 +0200
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Michael Chan <mchan@broadcom.com>
Subject: Re: tg3 kernel bug in 2.6.18-mm3 and 2.6.19-rc2-mm2
Message-ID: <20061021234107.GA12918@gamma.logic.tuwien.ac.at>
References: <20061021132239.GA29288@gamma.logic.tuwien.ac.at> <20061021.123814.106436476.davem@davemloft.net> <20061021132239.GA29288@gamma.logic.tuwien.ac.at> <20061021100207.fdc240e0.akpm@osdl.org> <200610211918.30616.rjw@sisk.pl> <20061021132239.GA29288@gamma.logic.tuwien.ac.at> <20061021100207.fdc240e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061021.123814.106436476.davem@davemloft.net> <200610211918.30616.rjw@sisk.pl> <20061021100207.fdc240e0.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi all!

On Sam, 21 Okt 2006, Andrew Morton wrote:
> Can you test 2.6.19-rc2 plus the below?

2.6.19-rc2	works
2.6.19-rc2+patch does not work

So it is this patch.

hw:
Acer TravelMate 3012WMi
03:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789 Gigabit Ethernet PCI Express (rev 11)

If you need dmesg, .config, something else, no problem.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>                    Università di Siena
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DITHERINGTON (n)
Sudden access to panic experienced by one who realises that he is
being drawn inexorably into a clabby (q.v.) conversion, i.e. one he
has no hope of enjoying, benefiting from or understanding.
			--- Douglas Adams, The Meaning of Liff
