Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWBNSWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWBNSWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWBNSWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:22:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10437 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422752AbWBNSWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:22:17 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060214175305.GD19080@lst.de> 
References: <20060214175305.GD19080@lst.de> 
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: use kthread_ API 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 14 Feb 2006 18:22:09 +0000
Message-ID: <6243.1139941329@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> Use the kthread_ API instead of opencoding lots of hairy code for kernel
> thread creation and teardown.

NAK. The kthread API appears nowhere in the patch.

David
