Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVLMSCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVLMSCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVLMSCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:02:22 -0500
Received: from verein.lst.de ([213.95.11.210]:54227 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932460AbVLMSCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:02:20 -0500
Date: Tue, 13 Dec 2005 19:02:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] move MS_NOATIME mirroring inside xfs
Message-ID: <20051213180214.GA17309@lst.de>
References: <20051213175655.GE17130@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213175655.GE17130@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 06:56:55PM +0100, Christoph Hellwig wrote:
> XFS propagates MS_NOATIME through two levels internally but doesn't
> actually use it.  Kill this dead code.

The subject should read "remove MS_NOATIME mirroring inside xfs" of
course..

