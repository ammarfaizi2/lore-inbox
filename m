Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTETVTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 17:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTETVTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 17:19:47 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:16852 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261196AbTETVTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 17:19:46 -0400
Date: Tue, 20 May 2003 22:36:37 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Miles T Lane <miles_lane@yahoo.com>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: 2.5.69-bk14 (PPC build) -- drivers/char/agp/uninorth-agp.c:283: unknown field `suspend' specified in initializer
Message-ID: <20030520213637.GA7303@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Miles T Lane <miles_lane@yahoo.com>, linux-kernel@vger.kernel.org,
	paulus@samba.org
References: <20030520192051.70826.qmail@web40603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520192051.70826.qmail@web40603.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 12:20:51PM -0700, Miles T Lane wrote:
 > drivers/char/agp/uninorth-agp.c:283: unknown field
 > `suspend' specified in initializer
 > drivers/char/agp/uninorth-agp.c:283:
 > `agp_generic_suspend' undeclared here (not in a function)

Just kill the .suspend and .resume members of that structure.

		Dave
