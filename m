Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWDSR56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWDSR56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWDSR5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:57:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47789 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751090AbWDSR5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:57:24 -0400
Subject: Re: [RFC][PATCH 1/11] security: AppArmor - Integrate into kbuild
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 19:57:19 +0200
Message-Id: <1145469439.3085.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
> This patch glues AppArmor into the security configuration and Makefile.
> It also creates the AppArmor configuration and Makefile.


please use a "proper" patch ordering; it's not possible to apply this
patch only and get a building kernel, breaking bisection

