Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWD2VWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWD2VWa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 17:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWD2VW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 17:22:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42631 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750797AbWD2VW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 17:22:29 -0400
Subject: Re: another kconfig target for building monolithic kernel (for
	security) ?
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: devzero@web.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060429164331.GA26122@redhat.com>
References: <1093777985@web.de>  <20060429164331.GA26122@redhat.com>
Content-Type: text/plain
Date: Sat, 29 Apr 2006 23:22:26 +0200
Message-Id: <1146345747.3125.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-29 at 12:43 -0400, Dave Jones wrote:
> On Sat, Apr 29, 2006 at 03:03:55PM +0200, devzero@web.de wrote:
> 
>  > i want to harden a linux system (dedicated root server on the internet) by recompiling the kernel without support for lkm (to prevent installation of lkm based rootkits etc)
> 
> Loading modules via /dev/kmem is trivial thanks to a bunch of tutorials and
> examples on the web, so this alone doesn't make life that much more difficult for attackers.

/dev/kmem should be a config option too though

(and /dev/mem should get the filter patch that fedora has ;-) 


