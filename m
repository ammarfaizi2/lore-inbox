Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUAXHA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 02:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUAXHA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 02:00:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:15513 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266878AbUAXHA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 02:00:57 -0500
Date: Fri, 23 Jan 2004 22:59:56 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2
Message-ID: <20040124065955.GA2601@kroah.com>
References: <20040123013740.58a6c1f9.akpm@osdl.org> <20040123232906.GA4528@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040123232906.GA4528@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 12:29:06AM +0100, J.A. Magallon wrote:
> 
> On 01.23, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm2/
> > 
> > 
> 
> Still have to try with -mm2, but with mm1, my i2c temp sensors are scaled by 10 !!
> It is fun to read my processor runs at 400 ºC ;)
> 
> werewolf:/sys/bus/i2c/devices/1-0290# sensors -v
> sensors version 2.8.2
> werewolf:/sys/bus/i2c/devices/1-0290# cat temp_input1
> 38000
> werewolf:/sys/bus/i2c/devices/1-0290# cat temp_input2
> 40000
> 
> ??

Try using the latest version of lmsensors.  It should handle the proper
scaling issues.  If not, please let the lmsensors developers know.

thanks,

greg k-h
