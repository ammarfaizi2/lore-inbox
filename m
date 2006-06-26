Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWFZQus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWFZQus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWFZQqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:46:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38893 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750815AbWFZQqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:46:51 -0400
Date: Mon, 26 Jun 2006 12:45:36 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060626164536.GD18599@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060626151012.GR23314@stusta.de> <20060626153834.GA18599@redhat.com> <20060626161411.GT23314@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626161411.GT23314@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 06:14:11PM +0200, Adrian Bunk wrote:

 > If the virt_to_bus/bus_to_virt are fixed, Andrew might finally accept my 
 > patch to add -Werror-implicit-function-declaration to the CFLAGS (which 
 > he only rejected since it turned link errors into compile errors in his 
 > ppc64 builds). 

Indeed. That was so useful in fact that I added the same to the Fedora
kernel quite some time back.  Having a build fail in the first few minutes
is much preferable to having it fail after 15 minutes.

I've not encountered any breakage due to that for some time though.
Though perhaps Andrew had config options enabled that we disabled in
our builds.

		Dave

-- 
http://www.codemonkey.org.uk
