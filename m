Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTH3NL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTH3NL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:11:58 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:52322 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263529AbTH3NLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:11:44 -0400
Date: Sat, 30 Aug 2003 14:10:41 +0100
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matt Gibson <gothick@gothick.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Message-ID: <20030830131041.GA10554@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Matt Gibson <gothick@gothick.org.uk>, linux-kernel@vger.kernel.org
References: <200308281548.44803.tomasz_czaus@go2.pl> <20030828084640.68fe827d.rddunlap@osdl.org> <200308282002.00758.gothick@gothick.org.uk> <20030828151708.0b13dd82.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828151708.0b13dd82.rddunlap@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 03:17:08PM -0700, Randy.Dunlap wrote:
 > | As a result, I'm still no more enlightened.  I can't quite figure out from 
 > | reading the parser what values to put where, as it seems to expect a few 
 > | more than I have.  Any tips?
 > 
 > Yes, the kernel has decided that your processor only has 1 Bank of
 > MCE register data to report.  I don't know how/why.  Sorry.

The non-fatal checker dumps the single bank that is reporting failures.
parsemce should still have enough info there to decode into something
useful however.  (just use 0 for the address).

	Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
