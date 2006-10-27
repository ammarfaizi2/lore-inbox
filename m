Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752193AbWJ0Nu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbWJ0Nu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbWJ0Nu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:50:58 -0400
Received: from mxsf12.cluster1.charter.net ([209.225.28.212]:53179 "EHLO
	mxsf12.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1752191AbWJ0Nu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:50:57 -0400
X-IronPort-AV: i="4.09,365,1157342400"; 
   d="scan'208"; a="1875487711:sNHT48719742"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17730.3765.293365.848005@smtp.charter.net>
Date: Fri, 27 Oct 2006 09:50:45 -0400
From: "John Stoffel" <john@stoffel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: removing drivers and ISA support? [Was: Char: correct
	pci_get_device changes]
In-Reply-To: <1161900446.12781.86.camel@localhost.localdomain>
References: <4540F79C.7070705@gmail.com>
	<1161900446.12781.86.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> Ar Iau, 2006-10-26 am 19:59 +0200, ysgrifennodd Jiri Slaby:
>> Alan, do you consider some (char) driver to be removed now?

Alan> I think some of the drivers like epca we should seriously consider
Alan> dropping and seeing if there is any complaint, my guess will be not.

>> And what about (E)ISA support. When converting to pci probing,
>> should be ISA bus support preserved (how much is ISA used in
>> present)? -- it makes code ugly and long.

I'm still using my Cyclom-Y ISA 8-port serial card.  But that probably
won't be for too much longer if I get a new system... but it's still
in use!
