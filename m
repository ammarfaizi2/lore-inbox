Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUAWSyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUAWSyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:54:31 -0500
Received: from 62-43-5-49.user.ono.com ([62.43.5.49]:57028 "EHLO
	mortadelo.pirispons.net") by vger.kernel.org with ESMTP
	id S262566AbUAWSya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:54:30 -0500
Date: Fri, 23 Jan 2004 19:54:29 +0100
From: Kiko Piris <kernel@pirispons.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.2-rc1] unknown i2c symbols in bttv and friends
Message-ID: <20040123185429.GA4797@pirispons.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20040123183827.GA928@pirispons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123183827.GA928@pirispons.net>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2004 at 19:38, Kiko Piris wrote:

> I compiled 2.6.2-rc1 and I can't use my Pinnacle PCTV card because bbtv
> module and friends refuse to load due to unknown i2c_* symbols. dmesg
> relevant part is attached (kernel config is also - grep ^CONFIG -).

My fault. I had a forgotten line 

options i2c-core       i2c_debug=1

in modprobe.conf. Of course they wheren't loading! :-[

Sorry for the noise.

-- 
Kiko
