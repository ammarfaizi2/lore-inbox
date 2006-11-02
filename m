Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWKBQ5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWKBQ5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWKBQ5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:57:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10151 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750734AbWKBQ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:57:31 -0500
Subject: Re: Can Linux live without DMA zone?
From: Arjan van de Ven <arjan@infradead.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
In-Reply-To: <454A1D82.7040709@cfl.rr.com>
References: <20061102021547.GA1240@srv.junsun.net>
	 <454A1D82.7040709@cfl.rr.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 02 Nov 2006 17:57:22 +0100
Message-Id: <1162486642.14530.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 11:32 -0500, Phillip Susi wrote:
> Shouldn't only ancient ISA drivers be using GFP_DMA?  You know, ones 
> that actually require it?  PCI drivers should not have this limit.


that is a nice theory, but unfortunately there is just a lot of "PCI"
hardware out there for which the designers decided to save a bit of
copper and only wire up the lower X address lines (for various values of
X)
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

