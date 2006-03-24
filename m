Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWCXSLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWCXSLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWCXSLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:11:43 -0500
Received: from [81.2.110.250] ([81.2.110.250]:20438 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750821AbWCXSLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:11:42 -0500
Subject: Re: hpt366 with sata, increase ide controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060324123458.GA26508@stewarts.org.uk>
References: <20060324123458.GA26508@stewarts.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Mar 2006 18:18:11 +0000
Message-Id: <1143224291.20904.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-03-24 at 12:34 +0000, Thomas Stewart wrote:
> Is there a libata driver, in which case the number of letters would be
> a non issue. Or is there a way of getting the hpt366 module to only
> grab letters for drives present. Or is there another way to fix it?

The libata PATA patch has a patch for the HPT36x/37x but it is fairly
early days. It works for me and because the SATA core code knows about
PATA/SATA bridge setup does the right mode setting.

> As a very quick fix I wrote a patch to get things working. I am in no
> way experienced doing any of this stuff so it's mostly guess work. Nor
> am I gunning for this to be included. It's mostly just to put it out
> there so maybe others with similar problems can get going.

Looks sane enough as a hack for the moment.

