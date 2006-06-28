Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423222AbWF1Ink@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423222AbWF1Ink (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423221AbWF1Inj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:43:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47832 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423212AbWF1Ini (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:43:38 -0400
Subject: RE: [PATCH] ia64: change usermode HZ to 250
From: Arjan van de Ven <arjan@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>, Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <617E1C2C70743745A92448908E030B2A27F855@scsmsx411.amr.corp.intel.com>
References: <617E1C2C70743745A92448908E030B2A27F855@scsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 10:43:30 +0200
Message-Id: <1151484210.3153.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 15:26 -0700, Luck, Tony wrote:
> > -# define HZ 1024
> > +# define HZ 250
> 
> Is every distribution just using the default 250? 

I would hope not; it's a pretty big regression for the telco space
(which really wants 1 or 2 msec delays) so I hope/assume all the
enterprise distributions (which ia64 specially cares about) stick to the
old 1024 value...


