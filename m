Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266471AbUFQMt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266471AbUFQMt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266475AbUFQMt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:49:59 -0400
Received: from [213.146.154.40] ([213.146.154.40]:9387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266471AbUFQMt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:49:58 -0400
Date: Thu, 17 Jun 2004 13:49:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4]Diskdump Update
Message-ID: <20040617124957.GA31392@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <A0C44FA7FE6022indou.takao@soft.fujitsu.com> <A2C44FA9144378indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2C44FA9144378indou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my old comments for this are still valid, please add the actual dumping
methods directly to scsi_host_template instead of a pointer to another
method vector, please make it not a module of it's own but part of the
scsi code, please don't use "scsi.h" in new code, and the find gendisk
by dev_t code in sd.c is still no good.
