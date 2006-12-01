Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162390AbWLAXaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162390AbWLAXaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162387AbWLAX37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:29:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26335 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1162379AbWLAX34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:29:56 -0500
Date: Fri, 1 Dec 2006 15:29:22 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: thockin@hockin.org
Cc: Sebastian Kemper <sebastian_ml@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OHCI] BIOS handoff failed (BIOS bug?)
Message-Id: <20061201152922.93cc59a4.zaitcev@redhat.com>
In-Reply-To: <20061201232339.GA25645@hockin.org>
References: <20061201130359.GA3999@section_eight>
	<20061201182855.GA7867@section_eight>
	<20061201150201.4e8c9edb.zaitcev@redhat.com>
	<20061201232339.GA25645@hockin.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 15:23:39 -0800, thockin@hockin.org wrote:

> BIOS handoff assumes an SMI, right?  Could SMI be masked?

That might be a bad idea, because things like fans may be controlled
by SMM BIOS. The best thing we can do is to follow the published
procedure, and maybe insert a workaround if Sebastian can identify it.

-- Pete
