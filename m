Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264759AbUEYNgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbUEYNgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264760AbUEYNgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:36:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:6322 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264759AbUEYNgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:36:04 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Lustre VFS patch
Date: Tue, 25 May 2004 08:35:24 -0500
User-Agent: KMail/1.6
Cc: Lars Marowsky-Bree <lmb@suse.de>, braam <braam@clusterfs.com>,
       "'Jens Axboe'" <axboe@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "'Phil Schwan'" <phil@clusterfs.com>
References: <20040525064730.GB14792@suse.de> <20040525082305.BAEE93101A0@moraine.clusterfs.com> <20040525105252.GJ22750@marowsky-bree.de>
In-Reply-To: <20040525105252.GJ22750@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405250835.24110.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 May 2004 5:52 am, Lars Marowsky-Bree wrote:
> Maybe you could fix this in the test harness / Lustre itself instead and
> silently discard the writes internally if told so via an (internal)
> option, instead of needing a change deeper down in the IO layer, or use
> a DM target which can give you all the failure scenarios you need?
>
> In particular the last one - a fault-injection DM target - seems like a
> very valuable tool for testing in general, but the Lustre-internal
> approach may be easier in the long run.

See dm-flakey.c in the latest -udm patchset for a fairly simple version of a 
"fault-injection" target.

http://sources.redhat.com/dm/patches.html

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
