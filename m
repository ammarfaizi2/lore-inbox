Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTHaTWt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTHaTWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:22:49 -0400
Received: from www.stereoconnection.ca ([216.16.235.58]:59073 "EHLO
	nic.NetDirect.CA") by vger.kernel.org with ESMTP id S261598AbTHaTWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:22:48 -0400
Date: Sun, 31 Aug 2003 15:22:46 -0400
From: Chris Frey <cdfrey@netdirect.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Andrea VM changes
Message-ID: <20030831152246.A32685@netdirect.ca>
References: <3F52199B.5020808@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F52199B.5020808@kegel.com>; from dank@kegel.com on Sun, Aug 31, 2003 at 08:51:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 08:51:55AM -0700, Dan Kegel wrote:
> I spent way too long tweaking the OOM killer before I
> realized it was hopeless.
> The fact that incoming network traffic can be what causes the
> OOM condition makes it Really Hard to decide which app deserves
> the axe.

This may be a little off topic, but is there a way to manually select
this?  I can see having a mode where everything stops thrashing
for a while, in order to let the admin calmly kill off the offending
process, as a useful feature.

It would be useless in an environment where OOM is actually needed
(can't wait for a human admin to show up), but cool for those that
like to bring their machines back from the edge.

- Chris

