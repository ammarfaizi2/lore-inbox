Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWDMSIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWDMSIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWDMSIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:08:15 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:17831 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbWDMSIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:08:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tm+JZZCMbR0yLgJH8Scvt6eAOF0LnryZor0IS7J4ebOHYfDQe8M5PHgHk6BfvayBUzeY6aMAg2m+0nUNrpZ16bRbNlBSgRkL86tqpyKiK7XXuP3a/BkH6oZC37nePNaJez0i/IQcaYNTWMNvkYIvjkIka+DRURQt7JSj/hko8eU=
Message-ID: <625fc13d0604131108w68612124ga77fb5fd9f0a408c@mail.gmail.com>
Date: Thu, 13 Apr 2006 13:08:11 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 3/4] Remove unchecked flags
Cc: "Andrew Morton" <akpm@osdl.org>, "David Woodhouse" <dwmw2@infradead.org>,
       "Thomas Gleixner" <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060413165434.GG30574@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060413165153.GD30574@wohnheim.fh-wedel.de>
	 <20060413165434.GG30574@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> Several flags are set by some devices, but never checked.  Remove them.

As a side note, these will also need to be removed from the mtd-utils
tree.  The switch to git meant that mtd-utils has it's own copy of the
sanitized headers.  The patch for mtd-abi.h should apply there as
well.

josh
