Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUCaXPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUCaXPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:15:49 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:8579 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262774AbUCaXPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:15:48 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Date: Wed, 31 Mar 2004 15:15:01 -0800
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040317201454.5b2e8a3c.akpm@osdl.org> <200403311102.58136.jbarnes@sgi.com> <20040331120634.39c959fd.akpm@osdl.org>
In-Reply-To: <20040331120634.39c959fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403311515.01289.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 12:06 pm, Andrew Morton wrote:
> So are we to assume that this is the offending process?  That the periodic
> slab reaping code has screwed up?

It looks like it.  Disabling the slab cache reaping function allows it to boot 
again.

Jesse
