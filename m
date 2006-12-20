Return-Path: <linux-kernel-owner+w=401wt.eu-S1030362AbWLTVWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWLTVWi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWLTVWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:22:38 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:20719 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030324AbWLTVWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:22:36 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 16:22:35 EST
Date: Wed, 20 Dec 2006 22:15:44 +0100 (MET)
From: Stefan Rompf <stefan@loplof.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Network drivers that don't suspend on interface down
User-Agent: KMail/1.9.1
Cc: Olivier Galibert <galibert@pobox.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20061219185223.GA13256@srcf.ucam.org>
 <20061220152701.GA22928@dspnet.fr.eu.org>
 <1166628858.3365.1425.camel@laptopd505.fenrus.org>
In-Reply-To: <1166628858.3365.1425.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202217.31066.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. Dezember 2006 16:34 schrieb Arjan van de Ven:

> 5 seconds is unfair and unrealistic though. The *hardware* negotiation
> before link is seen can easily take upto 45 seconds already.
> That's a network topology/hardware issue (spanning tree fun) that
> software or even the hardware in your PC can do nothing about.

Spanning tree decides whether or not a port forwards traffic. It has nothing 
to do with link beat detection and autonegotation, so it shouldn't be an 
issue here.

Stefan
