Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVFHTgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVFHTgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFHTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:36:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34002 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261571AbVFHTgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:36:00 -0400
Date: Wed, 8 Jun 2005 15:35:56 -0400
From: Dave Jones <davej@redhat.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mtrr question
Message-ID: <20050608193556.GI876@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
References: <200506081917.09873.nick@linicks.net> <20050608192335.GG876@redhat.com> <200506082031.59987.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506082031.59987.nick@linicks.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 08:31:59PM +0100, Nick Warne wrote:

 > Ummm.  I see from boot logs that mtrr isn't detected like it is on my other 
 > (Dell) boxes.

Hmm, that sounds like it isn't compiled in. Though that doesn't make
sense why you still have a /proc/mtrr
 
 > This looks like my BIOS settings are wonky then.  What would it be 'called' to 
 > enable/disable mtrr on an AGP slot?

Its typically not a setting, just something the BIOS does as part
of its CPU initialisation.  I've never encountered a BIOS that had
it configurable.

		Dave
 
