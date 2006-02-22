Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWBVDUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWBVDUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWBVDUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:20:11 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:59809 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751268AbWBVDUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:20:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] make INPUT a bool
Date: Tue, 21 Feb 2006 22:20:04 -0500
User-Agent: KMail/1.9.1
Cc: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de>
In-Reply-To: <20060222031001.GC4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212220.05642.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 22:10, Adrian Bunk wrote:
> On Wed, Feb 22, 2006 at 03:44:38AM +0100, Herbert Poetzl wrote:
> > 
> >  config X86_P4_CLOCKMOD
> > 	depends on EMBEDDED
> 
> This one is an x86_64 only issue, and yes, it's wrong.

That's for P4, not X86_64... And since P4 clock modulation does not provide
almost any energy savings it was "hidden" under embedded.

-- 
Dmitry
