Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUJUMii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUJUMii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUJUMck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:32:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:44042 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268565AbUJUMb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:31:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: cijoml@volny.cz, linux-kernel@vger.kernel.org
Subject: Re: Hibernation and time and dhcp
Date: Thu, 21 Oct 2004 15:31:50 +0300
User-Agent: KMail/1.5.4
References: <200410202045.24388.cijoml@volny.cz>
In-Reply-To: <200410202045.24388.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410211531.50238.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 21:45, Michal Semler wrote:
> Hi guys,
> 
> with 2.6.9 hibernation to disk finally works! Thanks
> To ram it still don't work, system starts with lcd disabled - but it is 
> another story.
> 
> I have now this problem - when I hibernate and then system is started up in 
> other company, it don't update time and shows still for example 14:00 - when 
> I rehibernate for example in 20:00 - could you ask bios for current time? 
> It's better to have bad time about few seconds instead of hours.
> 
> Same problem with dhcp - it should ask for IP when rehibernate.

These should be handled in userspace. You can put together
some simple shell script to do it with (hwclock or ntpdate) and [u]dhcp*
--
vda

