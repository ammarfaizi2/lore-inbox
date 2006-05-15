Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWEOQYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWEOQYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWEOQYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:24:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60370 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932249AbWEOQYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:24:08 -0400
Subject: Re: Rlimit
From: Lee Revell <rlrevell@joe-job.com>
To: sej@sej.fr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4468A4D7.10603@gmail.com>
References: <6cN1B-3ky-5@gated-at.bofh.it> <6cN1B-3ky-3@gated-at.bofh.it>
	 <4468A4D7.10603@gmail.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 12:24:06 -0400
Message-Id: <1147710246.27252.258.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 17:57 +0200, sej.kernel wrote:
> Of course !!
> But if you want to increase mlock size you can't do it !
> setrlimit can only decrease process limits !
> I repeat my question : How to set mlock process for non-root process ?
> sej

Add to /etc/security/limits.conf:

*               memlock hard    unlimited

or whatever

Lee

