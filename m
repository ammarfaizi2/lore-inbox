Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbTIVVmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTIVVmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:42:31 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:23814 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262808AbTIVVmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:42:31 -0400
Date: Mon, 22 Sep 2003 23:42:12 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: John Bradford <john@grabjohn.com>, arjanv@redhat.com,
       ebiederm@xmission.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922234212.B28359@devserv.devel.redhat.com>
References: <200309222003.h8MK38kC000353@81-2-122-30.bradfords.org.uk> <20030922213732.GC29869@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030922213732.GC29869@mail.jlokier.co.uk>; from jamie@shareable.org on Mon, Sep 22, 2003 at 10:37:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 10:37:32PM +0100, Jamie Lokier wrote:
> We already see this problem with pure PCI devices.  The standard
> solution with PCI devices is to issue a PCI read after the write, to
> flush the write.

afaik only PCI memory accesses are posted, not io port accesses

