Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTDXAQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTDXAQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:16:47 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:20702 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264328AbTDXAQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:16:42 -0400
Date: Thu, 24 Apr 2003 01:28:10 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 intel i855PM AGP support
Message-ID: <20030424002810.GA16973@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <20030423150529.C8931@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423150529.C8931@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 03:05:29PM -0400, Bill Nottingham wrote:
 > Adds i855PM support. Mainly adding a PCI id, unfortunately, requires
 > renaming the i855GM PCI ids to avoid name conflict. Also renames some
 > of the i855GM constants from i855PM to i855GM.

Ah crap, I should've warned you about Christoph's changes from the
last day or so. Take a look at
http://www.codemonkey.org.uk/cruft/agpgart-bits.diff
and you'll see that there's been a bit of a shuffle,
and a move toward killing off that ->chipset enum.

		Dave

