Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270210AbTHGPjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTHGPjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:39:12 -0400
Received: from verein.lst.de ([212.34.189.10]:43736 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265531AbTHGPij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:38:39 -0400
Date: Thu, 7 Aug 2003 17:37:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mitch@0Bits.COM,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Message-ID: <20030807153756.GA30310@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Mitch@0Bits.COM,
	Erik Andersen <andersen@codepoet.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030807142624.GA29208@lst.de> <Pine.LNX.4.44.0308071147370.2696-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308071147370.2696-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 11:47:53AM -0300, Marcelo Tosatti wrote:
> > vmap() doesn't break DRM.  The external drm code just detects that
> > vmap is present and then uses the new interface, but this new code
> > also expects a new exported symbol.
> 
> And which symbol is that? 

Ask the DRI folks.  They posted a patch on lkml a few days ago.

