Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVAOIXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVAOIXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 03:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVAOIXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 03:23:10 -0500
Received: from mproxy.gmail.com ([216.239.56.248]:44976 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262241AbVAOIXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 03:23:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t/3R8gW+Og0EFE/1i7kn+1dYmNzcXfoecnCSLqrHegWK/TkQaOxxSklWcg7UDxBI/Kodj3O81gLtxEkHzUwtTyicz0/AiqjN7bHXiFOczRmIlfllHdLUGjUtXjTZJfJneUJfpCxJJ99Oug0Wj2jmCKqWbviYuiLHKHdpA6pTET0=
Message-ID: <21d7e99705011500233902097c@mail.gmail.com>
Date: Sat, 15 Jan 2005 19:23:07 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: covici@ccs.covici.com
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Helge Hafting <helge.hafting@hist.no>,
       David Lang <dlang@digitalinsight.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16871.48626.40973.996123@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <Pine.LNX.4.60.0501131820230.20576@dlang.diginsite.com>
	 <41E7A088.4010708@hist.no> <16871.48626.40973.996123@ccs.covici.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an apg card and it happens on that one as well.  How can I turn
> off drm -- just not load the dri module?
>

don't load the drm kernel module or make sure CONFIG_DRM is set to n..

Dave.
