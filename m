Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUEMPYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUEMPYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUEMPYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:24:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57766 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264012AbUEMPX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:23:57 -0400
Date: Thu, 13 May 2004 11:23:49 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens-dated-1085310070.4b1f@endorphin.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] AES i586 optimized
In-Reply-To: <Xine.LNX.4.44.0405131104230.16026-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0405131123260.16065-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, James Morris wrote:

> I got an oops when I loaded the tcrypt testing module with this code, on a 
> dual Xeon.

This was the regparm=3 issue.


- James
-- 
James Morris
<jmorris@redhat.com>


