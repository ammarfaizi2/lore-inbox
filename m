Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVCPSo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVCPSo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVCPSo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:44:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46021 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262738AbVCPSlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:41:06 -0500
Message-ID: <42387DB0.90305@pobox.com>
Date: Wed, 16 Mar 2005 13:40:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Tribble <prat@rice.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export dev_get_flags in net/core/dev.c to fix missing
 symbols
References: <1110916582.27963.1.camel@localhost.localdomain>
In-Reply-To: <1110916582.27963.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tribble wrote:
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.

Note that -nobody- uses these "bk receive" patches.  They just don't 
work.  They depend on the person running "bk receive" to have 
-precisely- the same tree as you at the time of the pull.

Either (1) a patch itself or (2) a patch + 'bk pull' info is needed.

	Jeff



