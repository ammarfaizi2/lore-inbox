Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbTDGIGZ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTDGIGZ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:06:25 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:62985 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263321AbTDGIGY (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:06:24 -0400
Date: Mon, 7 Apr 2003 09:17:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: SET_MODULE_OWNER?
Message-ID: <20030407091757.A28879@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, zwane@linuxpower.ca,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20030407064755.DEAD62C06C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030407064755.DEAD62C06C@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Apr 07, 2003 at 04:47:28PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 04:47:28PM +1000, Rusty Russell wrote:
> I thought it was completely useless, hence deprecated.
> 
> Anyone have any reason to defend it?

It's used in the net drivers to set their owner.  One could argue whether
it makes sense to use a macro for it or not, but as most drivers converted
to new-style refcounting use it I don't see any reason to deprecated it.

