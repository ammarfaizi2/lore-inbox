Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161434AbWASVmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161434AbWASVmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161437AbWASVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:42:50 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6588 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161434AbWASVmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:42:49 -0500
Subject: Re: RFC: OSS driver removal, a slightly different approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <20060119182859.GW19398@stusta.de>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe>  <20060119182859.GW19398@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 21:28:27 +0000
Message-Id: <1137706107.8471.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 19:28 +0100, Adrian Bunk wrote:
> > ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
> > ESS, Jazz16)", it would be a joke if it didn't...
> 
> That's not the problem, I should have added an explanation:


OSS supports several "not quite compatibles", notably Cyrix 55x0 systems
where the SB firmware blows up on 64/128K transfers. 
