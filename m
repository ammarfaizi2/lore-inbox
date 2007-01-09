Return-Path: <linux-kernel-owner+w=401wt.eu-S1751296AbXAIKjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXAIKjL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXAIKjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:39:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33548 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbXAIKjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:39:09 -0500
Message-ID: <45A370C9.2060404@pobox.com>
Date: Tue, 09 Jan 2007 05:39:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_via: PATA support, resubmit
References: <20070108122659.00c22754@localhost.localdomain>	<45A24159.7060001@pobox.com>	<20070108154249.6d8f5697@localhost.localdomain>	<45A2688E.3080503@pobox.com>	<20070108164050.60633505@localhost.localdomain>	<45A27278.9000007@pobox.com> <20070108171113.6c5d7985@localhost.localdomain>
In-Reply-To: <20070108171113.6c5d7985@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>>> Signed-off-by: Alan Cox <alan@redhat.com>
>> Looks good to me, modulo minor comments below...
> 
> New revision below
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, thanks for your patience :)

Two procedural notes:

* you should include the patch description in each resend, so that 
scripts can automatically suck it into git changelog.

* yet again you added whitespace:


[jgarzik@pretzel libata-dev]$ git-am --signoff --utf8 /g/tmp/mbox

Applying 'sata_via: PATA support'

Adds trailing whitespace.
.dotest/patch:11:
Adds trailing whitespace.
.dotest/patch:40:
Adds trailing whitespace.
.dotest/patch:74:
warning: 3 lines add trailing whitespaces.
Wrote tree 76aff322aa7259d077e20f61b7405e3b16423a2e
Committed: 2041f6a9e6c927512023621413c6333ee104e6d5


