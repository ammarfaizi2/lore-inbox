Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbUKXUWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbUKXUWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbUKXUWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:22:14 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:52408 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262836AbUKXUVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:21:13 -0500
Subject: Re: Suspend 2 merge: 34/51: Includes
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124132558.GB13034@infradead.org>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101297843.5805.324.camel@desktop.cunninghams>
	 <20041124132558.GB13034@infradead.org>
Content-Type: text/plain
Message-Id: <1101327443.3425.11.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 07:17:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 00:25, Christoph Hellwig wrote:
> please submit header changes together with the matching code changes.

I can split them a little, but most of these suspend2 specific includes
are used by multiple files. Ranges, for example, are used everywhere.

> And all this plugin thingies in here look like overengineering.

I can see that it might look that way, but it's actually fundamental to
the support for building as modules (which is required for LVM &
encryption), and has been really helpful in creating clear distinctions
between the different parts of suspend. It also provides a clear method
for someone to add support for their new wizz-bang storage method or
compressor.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

