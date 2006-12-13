Return-Path: <linux-kernel-owner+w=401wt.eu-S964837AbWLMAcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWLMAcb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWLMAcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:32:31 -0500
Received: from [81.2.110.250] ([81.2.110.250]:34977 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964831AbWLMAca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:32:30 -0500
Date: Wed, 13 Dec 2006 00:40:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Message-ID: <20061213004030.599907a2@localhost.localdomain>
In-Reply-To: <200612130148.34539.sshtylyov@ru.mvista.com>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 01:48:34 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Behold!  This is the driver for the Toshiba TC86C001 GOKU-S IDE controller,
> completely reworked from the original brain-damaged Toshiba's 2.4 version.

Actually un-nack the PCI quirk. While it is true the native mode is
relevant because of the way the BAR values work we know legacy bar values
are never "& 8" so the test is sufficient [but should be commented about
the assumption]

Alan
