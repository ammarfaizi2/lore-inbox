Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272939AbTHKSZD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272919AbTHKSY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:24:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:3772 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272939AbTHKSWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:22:34 -0400
Date: Mon, 11 Aug 2003 19:22:00 +0100
From: Dave Jones <davej@redhat.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Missing spin_unlock_irqrestore from rrunner driver.
Message-ID: <20030811182200.GA2954@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <E19mF4Z-0005Ep-00@tetrachloride> <20030811201148.A1246@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811201148.A1246@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:11:48PM +0200, Francois Romieu wrote:
 > > +			spin_unlock_irqrestore(&rrpriv->lock, flags);
 > >  			goto gf_out;
 > >  		}
 > >  		spin_unlock_irqrestore(&rrpriv->lock, flags);
 > > -
 > 
 > Bloat :o)

Agreed, yours a much nicer fix.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
