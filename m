Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTEOERw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTEOERw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:17:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6049 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263802AbTEOERv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 00:17:51 -0400
Date: Wed, 14 May 2003 21:30:14 -0700 (PDT)
Message-Id: <20030514.213014.91331736.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305142216.h4EMG3Gi009291@locutus.cmf.nrl.navy.mil>
References: <20030514.133645.35032116.davem@redhat.com>
	<200305142216.h4EMG3Gi009291@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Wed, 14 May 2003 18:16:03 -0400
   
   this would be pretty easy if one simply decided on a maximum number
   of atm devices to have in a system.  scanning the list of adapters
   would just involve atm_dev_lookup(itf num).
   
I don't understand why a fixed number of ATM devs is
required in order to keep all of the device list and locking
stuff in one place.
