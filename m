Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUDOVYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUDOVXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:23:41 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:34143 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262962AbUDOVVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:21:17 -0400
Date: Thu, 15 Apr 2004 23:29:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sipos Ferenc <sferi@mail.tvnet.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: off:latest binary nvidia driver won't compile with 2.6.6-rc1
Message-ID: <20040415212923.GA2656@mars.ravnborg.org>
Mail-Followup-To: Sipos Ferenc <sferi@mail.tvnet.hu>,
	lkml <linux-kernel@vger.kernel.org>
References: <1082061685.5837.2.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082061685.5837.2.camel@zeus.city.tvnet.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 10:41:25PM +0200, Sipos Ferenc wrote:
> Hi!
> 
> The outer module patch for .temp creation didn't solve the problem,
> compilation stops with can't fine Modules.synver in /usr/src/linux-
> 2.6.6-rc1.

You need to do a ' make modules' first, otherwise the Modules.symvers file
will not be created.

	Sam
