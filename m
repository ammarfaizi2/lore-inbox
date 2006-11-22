Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755892AbWKVNx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbWKVNx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755889AbWKVNx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:53:58 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:49318 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755886AbWKVNx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:53:57 -0500
Message-ID: <4564566F.7030202@fr.ibm.com>
Date: Wed, 22 Nov 2006 14:53:51 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dmitry Mishin <dim@openvz.org>
CC: Daniel Lezcano <dlezcano@fr.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>	<45633EDF.3050309@fr.ibm.com> <200611221121.59322.dim@openvz.org>
In-Reply-To: <200611221121.59322.dim@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dmitry Mishin wrote:

> This patch looks acceptable for us.

good. shall we merge it then ? see comment below.

> BTW, Daniel, we agreed to be based on the Andrey's patchset. I do not see a
> reason, why Cedric force us to make some unnecessary work and move existent
> patchset over his interface.

yeah it's a bit different from andrey's but not that much and it's more in 
the spirit of uts and ipc namespace (and user namespace if that reaches the
kernel one day :) so that's why i made the small changes.

It also helping the nsproxy/namespace syscalls to have a similar interface
to manipulate namespaces. who knows, soon we might be able to have a 'struct
namespace' with a ops field to define new namespace types ? 

I can also send a empty framework for user namespace  ;)

thanks for reacting !

C.
