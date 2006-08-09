Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWHIQNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWHIQNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWHIQNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:13:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58594 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751108AbWHIQNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:13:15 -0400
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward
	compatibilty?
From: Lee Revell <rlrevell@joe-job.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net,
       Sergei Steshenko <steshenko_sergei@list.ru>
In-Reply-To: <200608091207.26156.gene.heskett@verizon.net>
References: <200608091140.02777.gene.heskett@verizon.net>
	 <20060809184658.2bdfb169@comp.home.net>
	 <200608091207.26156.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 12:13:18 -0400
Message-Id: <1155139999.26338.178.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 12:07 -0400, Gene Heskett wrote:
> This walks and qwacks like the alsa interface has been diddled, again.
> But since it KNOWS what hardware its running, in this case an audigy
> 2, not Value, so why was apparently working code broken and then
> commited to the kernel tree? 

It's a bug.  The interface was not changed intentionally.  ALSA policy
for at least a year has been "no incompatible changes".

Lee

