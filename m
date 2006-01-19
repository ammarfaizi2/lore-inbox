Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWASSgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWASSgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWASSgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:36:37 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:35468 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1030322AbWASSgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:36:37 -0500
Date: Thu, 19 Jan 2006 19:36:12 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Phillip Susi <psusi@cfl.rr.com>
cc: govind raj <agovinda04@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID 5+0 support
In-Reply-To: <43CFCBB2.3050003@cfl.rr.com>
Message-ID: <Pine.LNX.4.60.0601191933250.14341@kepler.fjfi.cvut.cz>
References: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl> <43CFCBB2.3050003@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Phillip Susi wrote:

> Why on earth would you want to stripe two raid-5's instead of using one raid-5
> that is twice as big?  You'd get more usable disk space that way. 

Speed is the issue here, I believe. By stripping two RAID-5 arrays you 
ought to get the reliability of the RAID-5 but with considerably higher 
speed. That's basically why RAID-50 exists, I think.

Martin
