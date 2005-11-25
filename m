Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbVKYTYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbVKYTYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVKYTYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:24:06 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:58544 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751460AbVKYTYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:24:05 -0500
Subject: Re: 2.6.14-rt4: via DRM errors
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, dri-devel@lists.sourceforge.net,
       Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1132946020.8990.7.camel@laptopd505.fenrus.org>
References: <1132807985.1921.82.camel@mindpipe>
	 <1132829378.3473.11.camel@mindpipe>
	 <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>
	 <200511240731.56147.jbarnes@virtuousgeek.org>
	 <1132945536.20390.39.camel@mindpipe>
	 <1132946020.8990.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 14:23:49 -0500
Message-Id: <1132946629.20390.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 20:13 +0100, Arjan van de Ven wrote:
> of course sometimes having less but more coarse locks is actually
> faster. Taking/dropping a lock is not free. far from it. 

True but couldn't it be a problem for devices like unichrome where you
have 3D and MPEG acceleration and they have to play nice?  It just seems
like there may have been an implicit assumption that devices only
support one type of hardware acceleration.

Lee

