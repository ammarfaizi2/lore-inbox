Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbTGDLE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbTGDLE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:04:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45324 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265975AbTGDLE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:04:27 -0400
Date: Fri, 4 Jul 2003 12:18:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704121853.F4374@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030704090329.GA1975@wiggy.net> <20030704102018.A4374@flint.arm.linux.org.uk> <20030704093732.GA2159@wiggy.net> <20030704113156.E4374@flint.arm.linux.org.uk> <20030704103725.GA2306@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030704103725.GA2306@wiggy.net>; from wichert@wiggy.net on Fri, Jul 04, 2003 at 12:37:25PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 12:37:25PM +0200, Wichert Akkerman wrote:
> Previously Russell King wrote:
> > Ok, after discussing the problem with Arjan, can you try adding back
> > the 0x804 to 0x8ff io port range?
> 
> That reintroduces the freeze again.

Argh, ok.  Are you prepared to run through up to about 8 interations
using a binary search method to find the pesky port / range of ports?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

