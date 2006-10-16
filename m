Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWJPJM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWJPJM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWJPJM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:12:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26273 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161265AbWJPJM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:12:57 -0400
Date: Mon, 16 Oct 2006 02:12:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Fix a cpu hotplug race condition while tuning slab
 cpu caches
In-Reply-To: <20061016085439.GA6651@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610160211250.3209@schroedinger.engr.sgi.com>
References: <20061016085439.GA6651@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Ravikiran G Thirumalai wrote:

> Fix a cpu hotplug race condition while tuning slab cpu caches.

Acked-by: Christoph Lameter <clameter@sgi.com>

We probably have a huge number of similar races. Basically any use of 
the online cpu map has the potential of causing a race.
