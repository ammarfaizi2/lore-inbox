Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWFZP4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWFZP4B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWFZP4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:56:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23753 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750776AbWFZPz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:55:58 -0400
Date: Mon, 26 Jun 2006 11:54:39 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060626155439.GB18599@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060626151012.GR23314@stusta.de> <20060626153834.GA18599@redhat.com> <1151336815.3185.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151336815.3185.61.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 05:46:55PM +0200, Arjan van de Ven wrote:
 > On Mon, 2006-06-26 at 11:38 -0400, Dave Jones wrote:
 > > On Mon, Jun 26, 2006 at 05:10:12PM +0200, Adrian Bunk wrote:
 > >  > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
 > >  > on i386.
 > >  > 
 > >  > Without such warnings people will never update their code and fix 
 > >  > the errors in PPC64 builds.
 > > 
 > > .. and deprecating pm_send_all, cli, sti, restore_flags, check_region yadayada
 > > has really been a great success at motivating people to fix those up too.
 > 
 > cli/sti should just be removed, or at least have those drivers marked
 > BROKEN... nobody is apparently using them anyway...

Just ISDN really.

		Dave

-- 
http://www.codemonkey.org.uk
