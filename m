Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVKJNwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVKJNwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVKJNwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:52:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45470 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750878AbVKJNwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:52:35 -0500
Subject: PATA libata patches (and HPT)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <pan.2005.11.08.19.02.09.190896@sci.fi>
References: <1131471483.25192.76.camel@localhost.localdomain>
	 <pan.2005.11.08.19.02.09.190896@sci.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Nov 2005 14:23:35 +0000
Message-Id: <1131632615.20099.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put a new patch up which fixes the enablebits problems. It's not
really there for people to run off and test but because it now has a
full set of "first guess" hpt3xx driver code.

I've been through various drivers and tried to work out what we actually
should be doing with these chips. I'd appreciate review of that and
opinions from other folks hacking on hpt pata stuff.

Alan

http://zeniv.linux.org.uk/~alan/IDE


