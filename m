Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWITSdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWITSdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWITSdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:33:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:13699 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932217AbWITSdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:33:09 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
Date: Wed, 20 Sep 2006 20:32:59 +0200
User-Agent: KMail/1.9.3
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1158718722.29000.50.camel@galaxy.corp.google.com> <200609202014.48815.ak@suse.de> <1158776378.8574.95.camel@galaxy.corp.google.com>
In-Reply-To: <1158776378.8574.95.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202032.59329.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is not free for anonymous memory as it is overloaded with pointer to
> anon_vma. 

Sorry. But ->index should be free there.

> I think one single pointer consistent across all page usages 
> is just so much cleaner and simple...

It just costs you 0.2% of all your memory in all cases. Too much imho.

-Andi
