Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbVKDQWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbVKDQWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVKDQWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:22:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8116 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751604AbVKDQV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:21:59 -0500
Subject: Re: [PATCH 19/42]: ppc64: bugfix: crash on PHB add
From: John Rose <johnrose@austin.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
       External List <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051104005117.GA26991@mail.gnucash.org>
References: <20051103235918.GA25616@mail.gnucash.org>
	 <20051104005117.GA26991@mail.gnucash.org>
Content-Type: text/plain
Message-Id: <1131121255.9574.11.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Nov 2005 10:20:55 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes a bug related to dlpar PHB add, after a PHB removal.

This and patch 18 seem logically separate from the feature.  This
complicates review and adds to an already large patch set.  Could we
handle these separately?

Thanks-
John

