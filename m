Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUJTUgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUJTUgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270563AbUJTUgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:36:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8634 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269008AbUJTUfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:35:16 -0400
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "J. Ryan Earl" <heretic@clanhk.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410202255.56304.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098230132.23628.28.camel@krustophenia.net>
	 <1098231737.23628.42.camel@krustophenia.net>
	 <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua>
	 <200410202255.56304.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1098304347.2456.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 16:32:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 15:55, Denis Vlasenko wrote:
> 	padding is larger that code it aligns! Zero gain in speed,
> 	11 bytes wasted. >8(

Still too big to inline it?  You could submit a patch that converts it
to asm... :-)

Lee

