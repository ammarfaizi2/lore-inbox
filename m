Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVEXLu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVEXLu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVEXLu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:50:27 -0400
Received: from colin.muc.de ([193.149.48.1]:41992 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262001AbVEXLuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 07:50:16 -0400
Date: 24 May 2005 13:50:11 +0200
Date: Tue, 24 May 2005 13:50:11 +0200
From: Andi Kleen <ak@muc.de>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       rusty@rustycorp.com.au
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050524115011.GC86233@muc.de>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com> <20050524054617.GA5510@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524054617.GA5510@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > sending to only relevant cpus removes that ambiquity. 
> 
> Or grab the 'call_lock' before setting the upcoming cpu in the online_map.
> This should also avoid the race when a CPU is coming online.

Such a simple solution would be great.

-Andi
