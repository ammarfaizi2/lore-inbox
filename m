Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUDGWCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbUDGWCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:02:49 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:9343 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S261162AbUDGWCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:02:48 -0400
Date: Wed, 7 Apr 2004 17:02:24 -0500
From: Nathan Straz <nstraz@sgi.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407220224.GA26850@sgi.com>
Mail-Followup-To: Andy Isaacson <adi@hexapodia.org>, bug-coreutils@gnu.org,
	linux-kernel@vger.kernel.org
References: <20040406220358.GE4828@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406220358.GE4828@hexapodia.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 05:03:58PM -0500, Andy Isaacson wrote:
> Linux-kernel:  is this patch horribly wrong?
...
> to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
> enable this usage.

Adding the functionality to conv= doesn't seem right to me.  conv= is
for converting the data in some way.  This is just changing the way data
is written.  Right?

Have you looked at lmdd?  It supports O_DIRECT and many other things not
in the standard dd.
-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
