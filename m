Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVCRFcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVCRFcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 00:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVCRFcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 00:32:06 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:62875 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261339AbVCRFcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 00:32:04 -0500
Date: Fri, 18 Mar 2005 06:33:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nicolas Kaiser <nikai@nikai.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, domen@coderock.org
Subject: Re: [patch 12/12] scripts/mod/sumversion.c: replace strtok() with strsep()
Message-ID: <20050318053301.GA32433@mars.ravnborg.org>
References: <20050305153545.9769F1F1F0@trashy.coderock.org> <20050317212302.GB13119@mars.ravnborg.org> <20050318034620.0a8ac96d@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318034620.0a8ac96d@lucky.kitzblitz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 03:46:20AM +0100, Nicolas Kaiser wrote:
> * Sam Ravnborg <sam@ravnborg.org>:
> 
> > On Sat, Mar 05, 2005 at 04:35:45PM +0100, domen@coderock.org wrote:
> > > 
> > > Replaces strtok() with strsep()
> > 
> > Why - does it increase portability?
> 
>  "strtok() is not thread and SMP safe and strsep() should be
> used instead"
> 
> http://janitor.kernelnewbies.org/docs/driver-howto.html#3.3.1

It does not matter in this particular file.
But applied for consistency (so it does not show up if you grep for it).

	Sam
