Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbTDNVGV (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTDNVGV (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:06:21 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:46019 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263828AbTDNVGU (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:06:20 -0400
Date: Mon, 14 Apr 2003 22:17:40 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030414211740.GB11160@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Duncan Sands <baldrick@wanadoo.fr>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304142240.41999.baldrick@wanadoo.fr> <20030414210211.GB7831@suse.de> <200304142310.05110.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304142310.05110.baldrick@wanadoo.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 11:10:05PM +0200, Duncan Sands wrote:

 > Some places don't seem to know about BUG_ON, for example
 > (from include/linux/skbuff.h):

Right, BUG_ON was added later (possibly for the purpose of
marking unlikely branches).  I see your point now about gcc
not recognising branches which are going to be unlikely, but
whether or not it should is questionable IMO.

		Dave

