Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbUJ0GxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbUJ0GxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbUJ0Gus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:50:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10470 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262299AbUJ0GsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:48:08 -0400
Message-ID: <417F4497.3020205@pobox.com>
Date: Wed, 27 Oct 2004 02:47:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Chris Wedgwood <cw@taniwha.stupidest.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC] Rename SECTOR_SIZE to IDE_SECTOR_SIZE
References: <20041027060828.GA32396@taniwha.stupidest.org>
In-Reply-To: <20041027060828.GA32396@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> The token SECTOR_SIZE is used in multiple places that have (almost)
> the same defintion everywhere.
> 
> How do people feel about rename this vague token?

It's highly silly to rename the same name + the same value to multiple 
different names.

Put it in a common header somewhere, and only rename the oddballs (if any).

	Jeff



