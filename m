Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271346AbTG2Iv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271351AbTG2IuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 04:50:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:30686 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271346AbTG2IsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 04:48:14 -0400
Date: Tue, 29 Jul 2003 01:48:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-Id: <20030729014822.6488539d.akpm@osdl.org>
In-Reply-To: <20030728225947.GA1694@localhost.localdomain>
References: <20030728225947.GA1694@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balram Adlakha <b_adlakha@softhome.net> wrote:
>
> I cannot transfer files larger than 914 mb from an NFS mounted
> filesystem to a local filesystem. A larger file than that is
> simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
> works fine. Can it be the version of mount I'm using? Its the
> one that comes with util-linux-2.11y.

Works OK here, with `cp'.  How are you "transferring" the file?

You're sure there is sufficient disk space on the receiving end? (sorry)

Can you strace the copy operation, see why it terminates?

