Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTFKELO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTFKELO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:11:14 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:27884 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264099AbTFKELN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:11:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Wed, 11 Jun 2003 16:58:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.54065.747185.327285@gargle.gargle.HOWL>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Fix raid0 init failure
In-Reply-To: message from Zwane Mwaikambo on Tuesday June 10
References: <Pine.LNX.4.50.0306102154210.19137-100000@montezuma.mastecende.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 10, zwane@linuxpower.ca wrote:
> create_strip_zone was accessing uninitialised data via 
> zone->dev = conf->devlist 

Yes thank.  There are few more of those in other raid levels.  I'm
about to send a patch off to Linus.

NeilBrown
