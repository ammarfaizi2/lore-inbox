Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVCBTXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVCBTXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVCBTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:22:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49814 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262426AbVCBTSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:18:11 -0500
Date: Wed, 2 Mar 2005 14:18:03 -0500
From: Dave Jones <davej@redhat.com>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050302191802.GB1512@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ondrej Zary <linux@rainbow-software.org>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain> <20050302075037.GH20190@apps.cwi.nl> <4225D4B4.6020002@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4225D4B4.6020002@rainbow-software.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 03:59:00PM +0100, Ondrej Zary wrote:
 > >>The failure to invoke the ->init operator appears to be the bug.
 > >>The centaur code definitely wants the mcr init function to be called.
 > >
 > >Yes, I expected that to be the answer. Therefore #if 0 instead of deleting.
 > >But if calling ->init() is needed, and it has not been done the past
 > >three years, the question arises whether there are any users.
 > 
 > I'm running 2.6.10 on Cyrix MII PR333 and it works. Maybe the code is 
 > broken but I haven't noticed :-)

your /proc/mtrr is likely broken/suboptimal.

		Dave

