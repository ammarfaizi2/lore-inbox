Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbULOR5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbULOR5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbULOR5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:57:35 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:29876 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262419AbULOR51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:57:27 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: krmurthy@cisco.com
Subject: Re: Limiting memory allocated by buffer cache in 2.4 kernel
Date: Wed, 15 Dec 2004 09:56:23 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <013901c4e2b4$bd041ad0$f8074d0a@apac.cisco.com>
In-Reply-To: <013901c4e2b4$bd041ad0$f8074d0a@apac.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412150956.23799.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 15, 2004 6:45 am, N.C.Krishna Murthy (krmurthy) wrote:
> Hi,
>  I am using linux 2.4.22 kernel. Is there any way to limit the amount
> of memory allocated by buffer cache? Eariler versions used to have
> /proc/sys/vm/buffermem.

For that matter, is there a way to do this in 2.6?  We've seen problems caused 
by huge page caches pushing data allocations off-node, so it would be really 
nice to have a limit control...

Jesse
