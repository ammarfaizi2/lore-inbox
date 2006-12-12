Return-Path: <linux-kernel-owner+w=401wt.eu-S932269AbWLLR1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWLLR1M (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWLLR1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:27:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33682 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932269AbWLLR1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:27:10 -0500
Date: Tue, 12 Dec 2006 17:35:16 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in
 -git17]
Message-ID: <20061212173516.1b7dc654@localhost.localdomain>
In-Reply-To: <1165941542.24482.5.camel@stevo-desktop>
References: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
	<1165873362.20877.22.camel@stevo-desktop>
	<1165941542.24482.5.camel@stevo-desktop>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 10:39:02 -0600
Steve Wise <swise@opengridcomputing.com> wrote:

> All,
> 
> Bisecting reveals that this commit causes the problem:

Yes we know. There is a libata patch missing. As I said - if it is still
missing by -rc1 I'll sort out a diff.

Alan
