Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWGYPMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWGYPMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGYPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:12:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932411AbWGYPMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:12:31 -0400
Date: Tue, 25 Jul 2006 11:11:45 -0400
From: Dave Jones <davej@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp status report
Message-ID: <20060725151145.GG14964@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>,
	Pavel Machek <pavel@ucw.cz>
References: <200607251325.14747.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607251325.14747.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 01:25:14PM +0200, Rafael J. Wysocki wrote:

 > V. Freeing memory
 > 
 > Step (3) of the suspend procedure is completed by calling the same
 > functions that are normally used by kswapd, but in a slightly different way.
 > The part of swsusp responsible for that is referred to as 'the memory
 > shrinker' and it may sometimes be called by the suspend-to-RAM code as well

This isn't actually necessary though is it ?
(Ie, it's a bug that needs fixing?)

Good write-up btw, it may even be a nice addition to Documentation/power/  ?

		Dave

-- 
http://www.codemonkey.org.uk
