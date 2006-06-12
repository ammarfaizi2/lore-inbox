Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWFLRUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWFLRUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWFLRUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:20:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48574 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750880AbWFLRUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:20:40 -0400
Subject: Re: [PATCH] IPC namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net, clg@fr.ibm.com
In-Reply-To: <44898BF4.4060509@openvz.org>
References: <44898BF4.4060509@openvz.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:19:28 -0700
Message-Id: <1150132768.13644.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 18:55 +0400, Kirill Korotaev wrote:
> The patches in this thread add IPC namespace functionality
> additionally to already included in -mm tree UTS namespace.
> 
> This patch set allows to unshare IPCs and have a private set
> of IPC objects (sem, shm, msg) inside namespace. Basically, it is 
> another building block of containers functionality.
> 
> Tested with LTP inside namespaces.

Do you, by chance, have any test cases for this code that test the
unsharing itself, and not just the functionality before and after an
unshare?  

-- Dave

