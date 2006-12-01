Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162147AbWLAXCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162147AbWLAXCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162162AbWLAXCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:02:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1162147AbWLAXCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:02:33 -0500
Date: Fri, 1 Dec 2006 15:02:01 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Sebastian Kemper <sebastian_ml@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OHCI] BIOS handoff failed (BIOS bug?)
Message-Id: <20061201150201.4e8c9edb.zaitcev@redhat.com>
In-Reply-To: <20061201182855.GA7867@section_eight>
References: <20061201130359.GA3999@section_eight>
	<20061201182855.GA7867@section_eight>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 19:28:55 +0100, Sebastian Kemper <sebastian_ml@gmx.net> wrote:

> I also increased the wait time from 5 seconds to 20 in
> drivers/usb/host/pci-quirks.c but that didn't change anything.

That was a good try, but I thought maybe it needs doing something
twice, or having some extra bits set... There's always a possibility
that the BIOS refuses the handoff on purpose though. If it does not
cause any misbehaviour, it may be safe to ignore.

-- Pete
