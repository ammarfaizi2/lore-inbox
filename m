Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161404AbWATCbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161404AbWATCbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWATCbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:31:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61932 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161264AbWATCbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:31:22 -0500
Date: Thu, 19 Jan 2006 21:29:39 -0500
From: Dave Jones <davej@redhat.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, pfg@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 patch] drivers/sn/ must be entered for CONFIG_SGI_IOC3
Message-ID: <20060120022939.GA22184@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jes Sorensen <jes@sgi.com>,
	Adrian Bunk <bunk@stusta.de>, pfg@sgi.com,
	Linux Kernel <linux-kernel@vger.kernel.org>, tony.luck@intel.com,
	linux-ia64@vger.kernel.org
References: <20060117235521.GA14298@redhat.com> <20060119032423.GI19398@stusta.de> <yq0vewg7dc7.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0vewg7dc7.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:54:00AM -0500, Jes Sorensen wrote:
 > >>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:
 > 
 > Adrian> On Tue, Jan 17, 2006 at 06:55:21PM -0500, Dave Jones wrote:
 > >> kernel/drivers/serial/ioc3_serial.ko needs unknown symbol
 > >> ioc3_unregister_submodule
 > >> 
 > >> CONFIG_SERIAL_SGI_IOC3=m CONFIG_SGI_IOC3=m
 > 
 > Adrian> The untested patch below should fix it.
 > 
 > Actually I think this is more appropriate so we don't end up with 17
 > cases that add drivers/sn to the build lib.
 > 
 > Dave, does this solve the problem?

Yep, looks like it.

		Dave
