Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVFHTXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVFHTXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFHTXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:23:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24779 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261562AbVFHTXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:23:37 -0400
Date: Wed, 8 Jun 2005 15:23:35 -0400
From: Dave Jones <davej@redhat.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mtrr question
Message-ID: <20050608192335.GG876@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
References: <200506081917.09873.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506081917.09873.nick@linicks.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 07:17:09PM +0100, Nick Warne wrote:
 > Hello everybody,
 > 
 > Dumb question here.
 > 
 > I have an Athlon-thunderbird (1.2Ghz) on kernel 2.4.31 with mttr configured 
 > and a nVidia Geforce4.  /proc/mtrr is empty.

That's odd. you should at least have write-back entries for your system memory.
(Usually set up by the system BIOS)

 > Does/is setting up mtrr per the old 1999 Docs/mtrr.txt still relevant 
 > nowadays?  I can't seem to find a definitive answer using Google.

Yes, though the X driver should set them up itself on startup.

		Dave

