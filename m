Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161389AbWALWyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161389AbWALWyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWALWyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:54:52 -0500
Received: from havoc.gtf.org ([69.61.125.42]:60392 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161389AbWALWyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:54:51 -0500
Date: Thu, 12 Jan 2006 17:54:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does a git pull have to be so big?
Message-ID: <20060112225434.GA27678@havoc.gtf.org>
References: <200601130845.29797.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601130845.29797.ncunningham@cyclades.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 08:45:29AM +1000, Nigel Cunningham wrote:
> I try to do pulls reasonably often, but they always seem to be huge downloads 
> - I'm sure they're orders of magnitude bigger than a simple patch would be. 
> This leads me to ask, do they have to be so big? I'm on 256/64 ADSL at home, 
> did a pull yesterday at work iirc, and yet the pull this morning has taken at 
> least half an hour. Am I perhaps doing something wrong?

Two answers here:

1) Every so often, you download the entire kernel history all over
again, if you are using pack files, since most repositories are repacked
occasionally.

2) Every change sends the full updated (albeit compressed) file,
not a patch.

	Jeff



