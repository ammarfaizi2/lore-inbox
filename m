Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbULFPQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbULFPQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbULFPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:16:08 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:59802 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261528AbULFPQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:16:07 -0500
Date: Mon, 6 Dec 2004 16:16:06 +0100
From: bert hubert <ahu@ds9a.nl>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Correctly determine amount of "free memory"
Message-ID: <20041206151606.GA4149@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Gregory Giguashvili <Gregoryg@ParadigmGeo.com>,
	linux-kernel@vger.kernel.org
References: <06EF4EE36118C94BB3331391E2CDAAD9CD060A@exil1.paradigmgeo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06EF4EE36118C94BB3331391E2CDAAD9CD060A@exil1.paradigmgeo.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 04:53:34PM +0200, Gregory Giguashvili wrote:
> Assuming that I define "free memory" as maximum memory that can be
> allocated without causing swapping, is there a way I can give the best
> "free memory" amount estimate?

On the side, it would not hurt to study 'overcommit' and mlock(2). The
answer to your question is not static unless care is taken.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
