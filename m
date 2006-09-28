Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWI1VAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWI1VAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWI1VAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:00:36 -0400
Received: from gw.goop.org ([64.81.55.164]:44761 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750876AbWI1VAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:00:35 -0400
Message-ID: <451C37FE.4070808@goop.org>
Date: Thu, 28 Sep 2006 14:00:46 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
References: <451C33B2.5000007@goop.org> <Pine.LNX.4.64.0609281647030.28756@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609281647030.28756@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> Seems that one of the modules tainted the kernel.  Any idea which?
>   

ath_pci, the atheros madwifi driver.  It was loaded, but not active 
(interface down).  I think it's pretty unlikely to be a factor here.

    J
