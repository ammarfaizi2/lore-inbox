Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTEAPVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTEAPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:21:19 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:6303 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261365AbTEAPVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:21:18 -0400
Date: Thu, 1 May 2003 16:32:49 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Daniel Taylor <dtaylor@vocalabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Boot failure, VIA chipset.
Message-ID: <20030501153249.GA19001@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Daniel Taylor <dtaylor@vocalabs.com>, linux-kernel@vger.kernel.org
References: <20030430214848.GB24111@suse.de> <Pine.LNX.4.44.0305010547210.1739-100000@dante.vocalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305010547210.1739-100000@dante.vocalabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 05:53:53AM -0400, Daniel Taylor wrote:
 > > CONFIG_INPUT=y
 > > CONFIG_VT=y
 > > CONFIG_VT_CONSOLE=y
 > >
 > All enabled, and I tried last night with a stripped down 386 only kernel.
 > 
 > No dice, dies hard even before printing the Kernel ID.
 > 
 > It is probably a BIOS compatability issue, but it works OK with 2.4. Since
 > the system actually works as it sits I've been taking my time debugging
 > the 2.5 issues.

The only other outstanding hang that I've seen was caused by ACPI.
Does it boot with acpi=off ?

		Dave

