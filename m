Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbUASPJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265159AbUASPJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:09:31 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:46264 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265153AbUASPJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:09:30 -0500
Date: Mon, 19 Jan 2004 07:09:22 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4 nfsd broken
Message-ID: <20040119150922.GJ1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>,
	linux-kernel@vger.kernel.org
References: <400BEFD3.60506@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400BEFD3.60506@mech.kuleuven.ac.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 03:55:15PM +0100, Panagiotis Issaris wrote:
> Loading nfsd.ko results in the following message:
> nfsd: Unknown symbol dnotify_parent

There was a patch for this posted as a reply to 2.6.1-mm4 that exports
dnotify_parent to modules.  You should get that.

Did you have any troubles with stale filehandles in 2.6.1?

Mike
