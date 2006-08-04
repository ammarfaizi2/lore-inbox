Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161324AbWHDRBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbWHDRBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161322AbWHDRBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:01:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59040 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161324AbWHDRBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:01:12 -0400
Date: Fri, 4 Aug 2006 13:01:02 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: runtime disable for softlockup
Message-ID: <20060804170102.GJ7265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060801183826.GM22240@redhat.com> <20060804004802.5524bfa6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804004802.5524bfa6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:48:02AM -0700, Andrew Morton wrote:
 > On Tue, 1 Aug 2006 14:38:26 -0400
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > The softlockup detector is damned handy, but a real pain if it
 > > prevents your distro installer from running.
 > 
 > Why is it triggering??

It blew up in a few cases circa FC4, which prevented installs, which
led me to do this 'just in case' for FC5. The actual lockups got
fixed up somewhere in between, but this is still a nice safety net.

		Dave

-- 
http://www.codemonkey.org.uk
