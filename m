Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbUBZIuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbUBZIuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:50:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:49682 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262740AbUBZIuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:50:09 -0500
Message-ID: <403DB324.9080702@aitel.hist.no>
Date: Thu, 26 Feb 2004 09:49:40 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3 sometimes freeze on "sync"
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403C7D4D.1040104@aitel.hist.no> <20040225013938.53179d6c.akpm@osdl.org>
In-Reply-To: <20040225013938.53179d6c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
>>2.6.3-mm3 (and 2.6.3-mm1) occationally freeze on "sync".
> 
> 
> yup. bug.  This should fix.

This seems to work for me.  I've booted 2.6.3-mm3 with this
patch.  I ran some syncs, then forced the machine to
swap with a big tar and ran some more syncs.  It works.

Is it also in mm4?

Helge Hafting

