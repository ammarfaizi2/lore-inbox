Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755884AbWKVNqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbWKVNqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbWKVNqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:46:54 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48836 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755875AbWKVNqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:46:53 -0500
Message-ID: <456454C4.5010803@fr.ibm.com>
Date: Wed, 22 Nov 2006 14:46:44 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Daniel Lezcano <dlezcano@fr.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Cedric Le Goater <clg@fr.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Dmitry Mishin <dim@sw.ru>,
       netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>	<45633EDF.3050309@fr.ibm.com> <20061121181655.GA14656@MAIL.13thfloor.at>
In-Reply-To: <20061121181655.GA14656@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> no problem here, but I think we will need another one,
> or some smart way to do the network isolation (layer 3)
> for the network namespace (as alternative to the layer 2
> approach) ...

My feeling (Dmitry and Daniel can correct me) is that it will be
addressed with an unshare-like flag : NETNS2 and NETNS3.
 
> as they are both complementary in some way, I'm not sure
> a single space will suffice ...

hmm, so you think there could be a 2 differents namespaces
for network to handle layer 2 or 3. Couldn't that be just a sub part
of net_namespace.

C.
