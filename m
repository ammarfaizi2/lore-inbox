Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTHTLu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTHTLu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:50:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34772 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261929AbTHTLuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:50:22 -0400
Date: Wed, 20 Aug 2003 12:49:37 +0100
From: Dave Jones <davej@redhat.com>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: drm as module -> Cannot allocate memory
Message-ID: <20030820114937.GB27341@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tuukka Toivonen <tuukkat@ee.oulu.fi>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.55.0308201324450.6320@stekt37>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.55.0308201324450.6320@stekt37>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 01:35:22PM +0300, Tuukka Toivonen wrote:
 > If I select AGP and DRM as modules, MGA module refuses to load. Here's a
 > log:
 > 
 > powerzone:/video# /usr/local/sbin/modprobe agpgart
 > Linux agpgart interface v0.100 (c) Dave Jones
 > powerzone:/video# /usr/local/sbin/modprobe mga
 > [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
 > FATAL: Error inserting mga
 > (/lib/modules/2.6.0-test3/kernel/drivers/char/drm/mga.ko): Cannot allocate memory

You missed out modprobe intel-agp

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
