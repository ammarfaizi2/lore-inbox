Return-Path: <linux-kernel-owner+w=401wt.eu-S1752149AbWLOOA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbWLOOA4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbWLOOA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:00:56 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:57612 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbWLOOAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:00:55 -0500
X-Greylist: delayed 1992 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 09:00:55 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=Yny52S+KA40EIF3GA5ojVQWHU/xYH3cepdnDNQBm8nVuzj6N5a7G1/P6eY7gX
	o3Y9Qz3YrPvI9cB4s4U4Q1uzA==
Date: Fri, 15 Dec 2006 14:27:41 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, Riku Voipio <riku.voipio@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061215132740.GD11579@xi.wantstofly.org>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122231656.GA9991@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:16:56AM +0100, Francois Romieu wrote:

> You can apply the patch below and 'modprobe r8169 ignore_parity_err=1'.

Is there a way we can have this done by default on the n2100?  I guess
that since it's a PCI device, there isn't much hope for that..?
