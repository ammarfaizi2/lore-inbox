Return-Path: <linux-kernel-owner+w=401wt.eu-S1751299AbXAIKkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXAIKkV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXAIKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:40:20 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33564 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbXAIKkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:40:19 -0500
Message-ID: <45A37110.2050309@pobox.com>
Date: Tue, 09 Jan 2007 05:40:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata-sff: Don't try and activate channels which are
 not in use
References: <20070108121005.4ab3fb79@localhost.localdomain>
In-Reply-To: <20070108121005.4ab3fb79@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> An ATA controller in native mode may have one or more channels disabled
> and not assigned resources. In that case the existing code crashes trying
> to access I/O ports 0-7.
> 
> Add the neccessary check.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied.  perfect form, except for the whitespace:


Applying 'libata-sff: Don't try and activate channels which are not in use'

Adds trailing whitespace.
.dotest/patch:12:
Adds trailing whitespace.
.dotest/patch:22:
Adds trailing whitespace.
.dotest/patch:30:
warning: 3 lines add trailing whitespaces.
Wrote tree 209dcf80a25abdd730fc84f379ba7b4981ca8249
Committed: 0711dff09b21432c70a0c44fa5110b38da28385b


