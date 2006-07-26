Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWGZGdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWGZGdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWGZGdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:33:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030410AbWGZGda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:33:30 -0400
Subject: Re: [PATCH] lockdep: don't pull in includes when lockdep disabled
From: Arjan van de Ven <arjan@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Ingo Molnar <mingo@elte.hu>, Zach Brown <zach.brown@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060726062647.GA8711@mellanox.co.il>
References: <20060704115656.GA1539@elte.hu>
	 <20060726062647.GA8711@mellanox.co.il>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 26 Jul 2006 08:33:19 +0200
Message-Id: <1153895599.2896.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 09:26 +0300, Michael S. Tsirkin wrote:
> Ingo, does the following look good to you?
> 
> Do not pull in various includes through lockdep.h if lockdep is disabled.

Hi,

can you tell us what this fixes? Eg is there a specific problem?
I mean... we're adding ifdefs so there better be a real good reason for
them.... fixing something real would be such a reason ;-)

Greetings,
    Arjan van de Ven

