Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272977AbTHKS2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272909AbTHKS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:27:48 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:18878 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272919AbTHKSZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:25:23 -0400
Date: Mon, 11 Aug 2003 19:24:51 +0100
From: Dave Jones <davej@redhat.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, James Simmons <jsimmons@infradead.org>
Subject: Re: Kconfig -- kill "if you want to read about modules, see" crap?
Message-ID: <20030811182451.GA3151@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Steven Cole <elenstev@mesatop.com>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, James Simmons <jsimmons@infradead.org>
References: <200308111400.h7BE01NL000208@81-2-122-30.bradfords.org.uk> <1060625643.1736.10.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060625643.1736.10.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:14:04PM -0600, Steven Cole wrote:

 > Here is a little patch to implement this for
 > drivers/input/keyboard/Kconfig for a start.  The patch also fixes some
 > module names which were wrong (cut and paste errors).

We could go one stage further, and add to Kconfig..

	MODULE_NAME=atkbd

for each option, which would also allow us to only show that info
of CONFIG_MODULES=y, as well as eliminating the redundancy.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
