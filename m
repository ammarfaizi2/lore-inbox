Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbUBPBx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUBPBx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:53:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:27060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265296AbUBPBxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:53:24 -0500
Date: Sun, 15 Feb 2004 17:53:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christophe Saout <christophe@saout.de>
Cc: hch@infradead.org, thornber@redhat.com, mikenc@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop
 device?) on 2.6.*)
Message-Id: <20040215175337.5d7a06c9.akpm@osdl.org>
In-Reply-To: <20040216014433.GA5430@leto.cs.pocnet.net>
References: <402A4B52.1080800@centrum.cz>
	<1076866470.20140.13.camel@leto.cs.pocnet.net>
	<20040215180226.A8426@infradead.org>
	<1076870572.20140.16.camel@leto.cs.pocnet.net>
	<20040215185331.A8719@infradead.org>
	<1076873760.21477.8.camel@leto.cs.pocnet.net>
	<20040215194633.A8948@infradead.org>
	<20040216014433.GA5430@leto.cs.pocnet.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> wrote:
>
> +	  This device-mapper target allows you to create a device that
>  +	  transparently encrypts the data on it. You'll need to activate
>  +	  the required ciphers in the cryptoapi configuration in order to
>  +	  be able to use it.

Is there more documentation that this?  I'd imagine a lot of crypto-loop
users wouldn't have a clue how to get started on dm-crypt, especially if
they have not used device mapper before.

And how do they migrate existing encrypted filesytems?
