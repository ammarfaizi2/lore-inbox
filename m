Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270310AbTGRSsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270316AbTGRSsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:48:05 -0400
Received: from 25.mdrx.com ([65.67.58.25]:55993 "EHLO duallie.mdrx.com")
	by vger.kernel.org with ESMTP id S270310AbTGRSsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:48:03 -0400
From: Brian Jackson <brian@brianandsara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: run-parts,find, kupdated: What are they and how to control them?
Date: Fri, 18 Jul 2003 14:02:54 -0500
User-Agent: KMail/1.5.2
References: <200307180925.24867.jbriggs@briggsmedia.com>
In-Reply-To: <200307180925.24867.jbriggs@briggsmedia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307181402.54692.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look for updatedb in your cron jobs. That's usually what causes a bunch of 
find activity for me. You can either diable them or setup /etc/updatedb.conf 
to prune some fs's/path's that don't need to be slocate'd. HTH

--Brian Jackson

On Friday 18 July 2003 08:25 am, joe briggs wrote:
> Please - can someone explain what happens here once a day when my machine
> becomes completely unusable, a tremendous amount of disk i/o begins to
> occur, and 'top' shows "run-parts" and "find" at > 80% cpu utilization.
> What are they doing?  Are they necessary?  Can they be controlled. In
> Googling for these answers first, all I see are compaints, but no answers.
> Can someone PLEASE either explain what these are doing and how they are
> controlled, or point me in the right direction? Many thanks.

-- 
OpenGFS -- http://opengfs.sourceforge.net
Home -- http://www.brianandsara.net

