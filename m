Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031263AbWKUSQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031263AbWKUSQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031249AbWKUSQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:16:57 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:11413 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S1031201AbWKUSQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:16:56 -0500
Date: Tue, 21 Nov 2006 19:16:55 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Cedric Le Goater <clg@fr.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Dmitry Mishin <dim@sw.ru>,
       netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
Message-ID: <20061121181655.GA14656@MAIL.13thfloor.at>
Mail-Followup-To: Daniel Lezcano <dlezcano@fr.ibm.com>,
	Kirill Korotaev <dev@sw.ru>, Cedric Le Goater <clg@fr.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dmitry Mishin <dim@sw.ru>, netdev@vger.kernel.org
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru> <45633EDF.3050309@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45633EDF.3050309@fr.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 07:01:03PM +0100, Daniel Lezcano wrote:
> Kirill Korotaev wrote:
> >Cedric,
> >
> >Dmitry Mishin and Daniel Lezcano are working together on the full
> >network namespace incorporating both needs of OpenVZ and VServer/IBM.
> >
> >Thanks,
> >Kirill
> 
> Kirill,
> 
> We will need this framework to move the network isolation code to the 
> ns_proxy/net_namespace structure. So if Cedric gives us a empty 
> framework it is fine, except if someone does not agree with it...

no problem here, but I think we will need another one,
or some smart way to do the network isolation (layer 3)
for the network namespace (as alternative to the layer 2
approach) ...

as they are both complementary in some way, I'm not sure
a single space will suffice ... 

best,
Herbert

>   -- Daniel.
