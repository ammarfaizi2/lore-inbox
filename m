Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272277AbTHNLTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 07:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272290AbTHNLTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 07:19:08 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:3333 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272277AbTHNLTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 07:19:07 -0400
Date: Thu, 14 Aug 2003 12:19:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] visws: we don't need VGA console !
Message-ID: <20030814121905.A32484@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030814104208.GA7457@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030814104208.GA7457@pazke>; from pazke@donpac.ru on Thu, Aug 14, 2003 at 02:42:08PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 02:42:08PM +0400, Andrey Panin wrote:
> Hi all,
> 
> I think subject is self explaining :)
> 
> BTW does PC-9800 need VGA console ?

-bool "VGA text console" if EMBEDDED || !X86
+bool "VGA text console"

might be a better fix, the depency is completly bogus.


