Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVKYTFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVKYTFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVKYTFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:05:53 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:15277 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750744AbVKYTFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:05:53 -0500
Subject: Re: 2.6.14-rt4: via DRM errors
From: Lee Revell <rlrevell@joe-job.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: dri-devel@lists.sourceforge.net,
       Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200511240731.56147.jbarnes@virtuousgeek.org>
References: <1132807985.1921.82.camel@mindpipe>
	 <1132829378.3473.11.camel@mindpipe>
	 <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>
	 <200511240731.56147.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 14:05:35 -0500
Message-Id: <1132945536.20390.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 07:31 -0800, Jesse Barnes wrote:
> Sounds interesting, but that would be card specific, right?  I mean,
> on some cards the 2d and 3d locks would have to be the same because of
> shared state or whatever, for example. 

Not especially, that's how most Linux drivers work.  The locking in the
DRM seems unusually coarse grained.

Lee

