Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271345AbTGQIuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271347AbTGQIuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:50:24 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:63655 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S271345AbTGQIuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:50:21 -0400
Date: Thu, 17 Jul 2003 11:05:08 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O6int for interactivity
Message-ID: <20030717090508.GE13611@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307170030.25934.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307170030.25934.kernel@kolivas.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas, Wed, Jul 16, 2003 16:30:25 +0200:
> O*int patches trying to improve the interactivity of the 2.5/6 scheduler for 
> desktops. It appears possible to do this without moving to nanosecond 
> resolution.
> 
> This one makes a massive difference... Please test this to death.
> 

tar ztf file.tar.gz and make something somehow do not like each other.
Usually it is tar, which became very slow. And listings of directories
are slow if system is under load (about 3), too (most annoying).

UP P3-700, preempt. 2.6.0-test1-mm1 + O6-int.

