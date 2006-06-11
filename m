Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWFKPM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWFKPM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 11:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWFKPM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 11:12:56 -0400
Received: from canuck.infradead.org ([205.233.218.70]:33411 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751626AbWFKPM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 11:12:56 -0400
Subject: Re: [PATCH] header install: cosmetic cleanups to kbuild
	infrastructure
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060611143427.GA21490@mars.ravnborg.org>
References: <20060611121005.GA1342@mars.ravnborg.org>
	 <1150030039.5213.254.camel@pmac.infradead.org>
	 <20060611143427.GA21490@mars.ravnborg.org>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 16:12:50 +0100
Message-Id: <1150038770.8184.0.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 16:34 +0200, Sam Ravnborg wrote:
> That was i thinko that slept through. In general avoiding all the
> specific dependencies in the mess that is named Makefile is good but
> in this case there is no good reason to use the prepare targets. 

OK, I've applied your patch and then switched that back to depend on
include/linux/version.h again. Thanks.

-- 
dwmw2

