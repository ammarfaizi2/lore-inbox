Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWF1Wy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWF1Wy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWF1Wy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:54:26 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:47328 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751656AbWF1WyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:54:25 -0400
Date: Wed, 28 Jun 2006 18:54:22 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Daniel Lezcano <dlezcano@fr.ibm.com>
cc: Andrey Savochkin <saw@swsoft.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       Al Viro <viro@ftp.linux.org.uk>, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
In-Reply-To: <44A2FA66.5070303@fr.ibm.com>
Message-ID: <Pine.LNX.4.64.0606281851300.16528@d.namei>
References: <20060626134945.A28942@castle.nmd.msu.ru> <m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
 <20060627215859.A20679@castle.nmd.msu.ru> <m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
 <20060628150605.A29274@castle.nmd.msu.ru> <44A2FA66.5070303@fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Daniel Lezcano wrote:

> The attached patch can have some part interesting for you for the socket
> tagging. It is in the IPV4 isolation (part 5/6). With this and the private
> routing table you will probably have a good IPV4 isolation.

Please send patches inline, do not attach them.

(Perhaps we should have a filter on vger which drops emails with 
attachements).

All of this needs to be done in a way where it can be entirely disabled at 
compile time, so there is zero overhead for people who don't want 
network namespaces.


- James
-- 
James Morris
<jmorris@namei.org>
