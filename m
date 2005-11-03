Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbVKCVsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbVKCVsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbVKCVsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:48:10 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:35802 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1030508AbVKCVsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:48:08 -0500
Date: Thu, 3 Nov 2005 13:47:51 -0800
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Krufky <mkrufky@m1k.net>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org
Message-ID: <20051103214751.GA9407@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, Michael Krufky <mkrufky@m1k.net>,
	linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
References: <436723F8.4000602@m1k.net> <20051103135504.1dfa2db1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103135504.1dfa2db1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 12.154.195.17
Subject: Re: [PATCH 21/37] dvb: Add support for Air2PC/AirStar 2 ATSC 3rd generation (HD5000)
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 01:55:04PM +1100, Andrew Morton wrote:
> Michael Krufky <mkrufky@m1k.net> wrote:
> >
> > +			return -EREMOTEIO;
> 
> That's the first time I've seen anyone use EREMOTEIO ;) Any idea what it
> was added to Unix for?
> 
> hm, DVB seems to like it.

DVB's usage of EREMOTEIO actually comes from drivers/i2c/.
I suppose it means that the error didn't happen at the
bus driver but was caused the device behind the bus,
although I'm not sure if one can really tell those cases
from one another.

Johannes
