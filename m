Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTH3Nwn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTH3Nwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:52:43 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:41317 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261772AbTH3Nwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:52:42 -0400
Date: Sat, 30 Aug 2003 14:51:37 +0100
From: Dave Jones <davej@redhat.com>
To: Matt Gibson <gothick@gothick.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Message-ID: <20030830135137.GA679@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Gibson <gothick@gothick.org.uk>, linux-kernel@vger.kernel.org
References: <200308281548.44803.tomasz_czaus@go2.pl> <200308301344.56545.gothick@gothick.org.uk> <20030830133509.GA686@redhat.com> <200308301448.30810.gothick@gothick.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308301448.30810.gothick@gothick.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 02:48:30PM +0100, Matt Gibson wrote:
 > On Saturday 30 Aug 2003 14:35, you wrote:
 > > When it was i=0 people were seeing false positives. Starting from 1
 > > reduces that.
 > Cool.  Can you point me towards any background-reading on MCE?  This's got me 
 > interested.

not sure if any of the public amd docs have info on the mce registers,
but the stuff in the intel system archicture manuals on
developer.intel.com is largely relevant.

 > Rather ironically, since I changed my kernel back to starting from 0, I 
 > haven't seen any errors.

coincidence. By enabling more error checking you're seeing less doesn't
really make sense.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
