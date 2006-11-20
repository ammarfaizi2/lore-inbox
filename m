Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934242AbWKTPiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934242AbWKTPiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934243AbWKTPiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:38:55 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:54688 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S934241AbWKTPiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:38:54 -0500
Message-ID: <4561CC0D.2070900@s5r6.in-berlin.de>
Date: Mon, 20 Nov 2006 16:38:53 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] WorkStruct: Typedef the work function prototype
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <20061120142718.12685.84850.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061120142718.12685.84850.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Define a type for the work function prototype.  It's not only kept in the
> work_struct struct, it's also passed as an argument to several functions.

If so, it should certainly also be used in the declarations and
definitions of the work functions.
-- 
Stefan Richter
-=====-=-==- =-== =-=--
http://arcgraph.de/sr/
