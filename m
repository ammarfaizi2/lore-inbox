Return-Path: <linux-kernel-owner+w=401wt.eu-S1751113AbXACWJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbXACWJH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbXACWJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:09:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:44202 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbXACWJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:09:05 -0500
Subject: Re: [PATCH] radeonfb: add support for newer cards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Luca <kronos.it@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	 <20070101214442.GA21950@dreamland.darkstar.lan>
	 <1167696853.23340.156.camel@localhost.localdomain>
	 <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
	 <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 09:08:42 +1100
Message-Id: <1167862122.6165.164.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there a list of cards this adds support for?  I'm waiting on support 
> for the X1600

This is not supported, neither by radeonfb (patches or not) nor by
X.org. X1xxx cards have a new display engine and ATI refuses to provide
any specs for it.

Note: I wonder how much of that is related to M$ new Vista DRM that
basically forbids video or sound card vendors from providing specs or
doing open source or they get "revoked" and never get to see "HD"
content... 

Ben.


