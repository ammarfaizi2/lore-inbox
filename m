Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWB0NHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWB0NHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 08:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWB0NHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 08:07:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54943 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751088AbWB0NHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 08:07:08 -0500
Subject: Re: [Lse-tech] Re: [Patch 2/7] Add sysctl for schedstats
From: Arjan van de Ven <arjan@infradead.org>
To: balbir@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <20060227122933.GE22492@in.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141027367.5785.42.camel@elinux04.optonline.net>
	 <1141027923.5785.50.camel@elinux04.optonline.net>
	 <20060227085203.GB3241@elte.hu> <20060227104634.GB22492@in.ibm.com>
	 <1141042725.2992.96.camel@laptopd505.fenrus.org>
	 <20060227122933.GE22492@in.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 14:06:46 +0100
Message-Id: <1141045606.2992.98.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 17:59 +0530, Balbir Singh wrote:
> > your sysctl functions sleep. the BKL is useless in the light of sleeping
> > code...
> >
> 
> But wouldn't all sysctls potentially sleep (on account of copying data from
> the user).

.. I'm not the one saying the BKL was useful... you were ;)


