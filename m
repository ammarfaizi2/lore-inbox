Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWH3NCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWH3NCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWH3NCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:02:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28050 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750956AbWH3NCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:02:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1156942162.11819.1.camel@kleikamp.austin.ibm.com> 
References: <1156942162.11819.1.camel@kleikamp.austin.ibm.com>  <44F4ADD7.4020604@s5r6.in-berlin.de> <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com> <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com> <18771.1156926354@warthog.cambridge.redhat.com> <44F54FB0.7080203@s5r6.in-berlin.de> 
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 14:02:01 +0100
Message-ID: <18044.1156942921@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:

> Would this make more sense?
> 
> 	depends on USB && BLOCK
> 	select SCSI

That, though, is redundant, since SCSI depends on BLOCK.

David
