Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVDFX0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVDFX0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVDFX0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:26:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19598 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262345AbVDFXZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:25:49 -0400
Date: Wed, 6 Apr 2005 19:25:47 -0400
From: Dave Jones <davej@redhat.com>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc2
Message-ID: <20050406232547.GG9062@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bob Gill <gillb4@telusplanet.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1112829652.8941.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112829652.8941.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 05:20:52PM -0600, Bob Gill wrote:
 > OK.  So far so good.  I can get 2.6.12-rc2 to run fine if:
 > 1. I do not in any way attempt to *ahem* overclock the box.
 > --if I do, I get really ugly race errors flying around from just about
 > everywhere (pick a device at random, have it trip, and the scheduler
 > tripping right behind it).

"Doctor it hurts when I do this.."

 > 2. I do not attempt in any way to run any sort of Nvidia (non-GPL)
 > driver. 

Totally unsurprising. They'll need serious brain surgery
to work with the multi-gart support. I'm amazed they even
compiled for you.

		Dave

