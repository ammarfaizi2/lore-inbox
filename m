Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264972AbUEYQ4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbUEYQ4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUEYQ4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:56:33 -0400
Received: from mail.zmailer.org ([62.78.96.67]:61638 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S264972AbUEYQ4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:56:30 -0400
Date: Tue, 25 May 2004 19:56:27 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "A. op de Weegh" <aopdeweegh@rockopnh.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Granting some root permissions to certain users
Message-ID: <20040525165627.GT1749@mea-ext.zmailer.org>
References: <jbm.20040525185001.f766d1ea@TOSHIBA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jbm.20040525185001.f766d1ea@TOSHIBA>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 06:50:01PM +0200, A. op de Weegh wrote:
> Hi all,
> At our school, we have a installed Fedora Core 1 on a machine which acts as a 
> server. Our students may store reports and other products, that they have 
> created for their lessons, on this machine. Also the teachers have an 
> account.
>  
> I would like the teachers to have list access on ALL directories. Just as the 
> root user has. I wouldn't like the teachers to have all root permissions, but 
> they should only be able to list ALL directories available. Viewing only, no 
> writing.

That is usually done by means of supplementary groups.

And then somehow enforcing users to have their file/directory permissions
to include group X for directories, and group R for everything.

This means also, that users are allocated just a few groups, not
a group for each user (like FC1 does by default)

> Any idea how I can achieve this?
>  
> Thanx,
> Alex

/Matti Aarnio
