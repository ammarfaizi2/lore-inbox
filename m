Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUDVSIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUDVSIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264613AbUDVSIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:08:10 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:28044 "EHLO
	home.holviala.com") by vger.kernel.org with ESMTP id S264571AbUDVSIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:08:07 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse: fix mouse hotplugging
Date: Thu, 22 Apr 2004 21:08:06 +0300
User-Agent: KMail/1.6.1
References: <200404221546.i3MFka6w004059@eeyore.valparaiso.cl>
In-Reply-To: <200404221546.i3MFka6w004059@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404222108.06373.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 18:46, Horst von Brand wrote:

> > This patch fixes hotplugging of PS/2 devices on hardware which don't
> > support hotplugging of PS/2 devices. In other words, most desktop
> > machines.
>
> I have seen "hoplugging of mice" fry PS/2 ports, and heard of motherboards
> killed that way.

And I've heard people rm -rf'ing their root. Yet rm is still included.

Anyway, the patch should also fix rare cases of KVM weirdness and an even 
rarer cases of mouse not detected properly at boot.




Kim
