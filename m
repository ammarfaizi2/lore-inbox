Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbVIOQTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbVIOQTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030512AbVIOQTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:19:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40355 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030511AbVIOQTn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:19:43 -0400
Date: Thu, 15 Sep 2005 17:19:41 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: add endian annotations
Message-ID: <20050915161941.GB25261@ZenIV.linux.org.uk>
References: <20050915160537.GA11481@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915160537.GA11481@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:05:37PM +0400, Alexey Dobriyan wrote:

Merged.  Since you are touching that pile, could you kill the use of
endianness-dependent bitfields and go for inlined helpers instead?
