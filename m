Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbTAOUSf>; Wed, 15 Jan 2003 15:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbTAOUSf>; Wed, 15 Jan 2003 15:18:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29079 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267138AbTAOUSe>;
	Wed, 15 Jan 2003 15:18:34 -0500
Date: Wed, 15 Jan 2003 20:23:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Taprogge <jens.taprogge@rwth-aachen.de>,
       Yaacov Akiba Slama <ya@slamail.org>, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@csd.uu.se>, zwane@holomorphy.com,
       bvermeul@blackstar.nl, dave@codemonkey.org.uk
Subject: Re: [PATCH] Re: [BUG] cardbus/hotplugging still broken in 2.5.56
Message-ID: <20030115202321.GA16527@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Taprogge <jens.taprogge@rwth-aachen.de>,
	Yaacov Akiba Slama <ya@slamail.org>, linux-kernel@vger.kernel.org,
	Mikael Pettersson <mikpe@csd.uu.se>, zwane@holomorphy.com,
	bvermeul@blackstar.nl, dave@codemonkey.org.uk
References: <20030115081109.GA3839@valsheda.taprogge.wh> <15909.9796.157927.447889@harpo.it.uu.se> <3E258BBC.7010902@slamail.org> <20030115194738.GA2377@valsheda.taprogge.wh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115194738.GA2377@valsheda.taprogge.wh>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 08:47:38PM +0100, Jens Taprogge wrote:
 > You are not freeing the possibly already allocated resources in case of
 > a failure of either pci_assign_resource() or pca_enable_device(). In
 > fact you are not even checking if pci_assign_resource() fails. That
 > seems wrong to me.
 > 
 > Btw.: who is in charge of this file? Dave Jones?

Not me, more likely David Hinds.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
