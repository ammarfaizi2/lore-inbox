Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbUCTMLl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 07:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbUCTMLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 07:11:41 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:39571 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263384AbUCTMLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 07:11:40 -0500
Date: Sat, 20 Mar 2004 13:11:37 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: BIND fails to start with 2.6.4[5-rc1]
Message-ID: <20040320121137.GD7714@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200403201357.16203.tarkane@solmaz.com.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403201357.16203.tarkane@solmaz.com.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Tarkan Erimer wrote:

> I  have an interesting problem. BIND (BIND 9.2.3) is not working with 
> linux-2.6.4 and linux-2.6.5-rc1 (haven't tried linux-2.6.5-rc2, yet). But 
> linux-2.6.4-rc2 works fine with BIND. When the system boots and starts 
> BIND daemon, I got the following error message:
> 
> Starting BIND:  /usr/sbin/named
> named: capset failed: Operation not permitted

Did you configure standard linux capabilities in the security models
section?
