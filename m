Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTD3VhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTD3VhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:37:19 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:17340 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262423AbTD3VhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:37:18 -0400
Date: Wed, 30 Apr 2003 22:48:48 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Daniel Taylor <dtaylor@vocalabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Boot failure, VIA chipset.
Message-ID: <20030430214848.GB24111@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Daniel Taylor <dtaylor@vocalabs.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304301108240.7276-100000@dtaylor.vocalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304301108240.7276-100000@dtaylor.vocalabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:11:54AM -0500, Daniel Taylor wrote:
 > I have a KT400-based system that will not boot the 2.5 series kernels.
 > 
 > It fails with a hard lock immediately after the video mode query when
 > VGA=ask is set in /etc/lilo.conf.
 > 
 > If anyone else is working on this contact me, otherwise I'll post
 > my results when I get it working.

make sure you enabled

CONFIG_INPUT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y

		Dave
