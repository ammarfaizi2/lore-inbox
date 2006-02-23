Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWBWXx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWBWXx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWBWXx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:53:57 -0500
Received: from mx1.suse.de ([195.135.220.2]:27572 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932148AbWBWXx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:53:56 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Status of X86_P4_CLOCKMOD?
Date: Fri, 24 Feb 2006 00:55:30 +0100
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       davej@codemonkey.org.uk, Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
References: <20060214152218.GI10701@stusta.de> <200602240016.00317.ak@suse.de> <20060223233328.GB3674@stusta.de>
In-Reply-To: <20060223233328.GB3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240055.30603.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 00:33, Adrian Bunk wrote:

> EMBEDDED is the wrong option, since the semantics of embedded is "show
> more options to allow additional space savings". It is not and should
> not be abused as an option to hide random options from users.

I disagree. And I originally added most EMBEDDED users to the kernel.
The purpose I added it for was to hide options that only useful
for a very limited userbase but cause big or subtle trouble when set
wrong. P4_CLOCKMOD clearly qualifies.

-Andi

