Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbULHSW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbULHSW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULHSW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:22:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63972 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261273AbULHSWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:22:00 -0500
Date: Wed, 8 Dec 2004 13:21:34 -0500
From: Dave Jones <davej@redhat.com>
To: Felix Dorner <felix_do@web.de>
Cc: linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
Subject: Re: internal card reader support
Message-ID: <20041208182134.GB2345@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Felix Dorner <felix_do@web.de>, linux-kernel@vger.kernel.org,
	linux-laptop@mobilix.org
References: <41B74174.3080908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B74174.3080908@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 06:01:24PM +0000, Felix Dorner wrote:
 > Hi,
 > 
 > 
 > My notebook (hp nx9105) has an integrated 5in1 card-reader. I would 
 > really like to use this with linux.
 > Since I do not think it is supported yet, I d like to know if it might 
 > be possible to write a module or so for this.
 > I am just an average C programmer, but always wanted to dive into kernel 
 > developement. My knowledge on computer architecture is also no more than 
 > basic, so this might be something to really learn a lot...
 > So I start at zero knowledge now. First of course I need to find out if  
 > what I want to do is possible at all.

All of these devices that I've seen use the usb-storage module.
You might need to futz with the scsi_mod module max_luns argument to make it
see all the slots though.

		Dave

