Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWFYGdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWFYGdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 02:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWFYGdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 02:33:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751411AbWFYGdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 02:33:46 -0400
Date: Sun, 25 Jun 2006 02:31:51 -0400
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Knut J Bjuland <knutjbj@online.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: I can cause kernel panic by using native alsa midi with 2.6.17.1
Message-ID: <20060625063151.GE26273@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Knut J Bjuland <knutjbj@online.no>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200606250207_MC3-1-C35F-F5F8@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606250207_MC3-1-C35F-F5F8@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 02:03:21AM -0400, Chuck Ebbert wrote:
 > In-Reply-To: <449B8A0D.60607@online.no>
 > 
 > On Fri, 23 Jun 2006 08:28:29 +0200, Knut J Bjuland wrote:
 > 
 > > ksymoops 2.4.9 on i686 2.6.17-1.2138_FC5smp.  Options used
 > 
 > Please do not run oops reports through ksymoops.  The recipient
 > can do that.  And report Fedora bugs to Fedora...

It's already in Fedora bugzilla. It matches the same thing I reported
here a few days ago. With a list-head debug patch (kinda sorta
the same as the one in -mm), alsa goes boom.

		Dave

-- 
http://www.codemonkey.org.uk
