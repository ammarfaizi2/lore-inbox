Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265655AbUFOO3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUFOO3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUFOO3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:29:20 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:38377 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S265655AbUFOO3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:29:18 -0400
Date: Tue, 15 Jun 2004 16:29:12 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Matthew Denner <matt@denner.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 45 minute boot time with 2.6.4/2.6.6-mm5 kernel on 1.7GHz laptop
Message-ID: <20040615142912.GA30380@localhost>
References: <40CEFC9E.2030508@denner.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <40CEFC9E.2030508@denner.demon.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 15th 2004 Matthew Denner wrote:

> [extremely slowly functioning laptop]
> 
> Output from 'cat /proc/interrupts':
>            CPU0
>   ...
>  20:     270154   IO-APIC-level  eth0

This seems perhaps quite high? On occasion I have to use a configuration
where the network interface is configured by DHCP. When I take the
interface down (ifdown eth0) but forget to assign it its usual network
address (when changing location to another network) some interaction
with the still running DHCP client (pump) makes my laptop crawl just like
you describe. So if all other suggested options fail, you might want to
check if you maybe have such a runaway DHCP client causing havoc.
-- 
Marco Roeland
