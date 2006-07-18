Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWGRSX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWGRSX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWGRSX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:23:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4835 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932241AbWGRSX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:23:58 -0400
Date: Tue, 18 Jul 2006 14:23:28 -0400
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, linux-mm@kvack.org
Subject: Re: [PATCH] vm/agp: remove private page protection map
Message-ID: <20060718182328.GA7567@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk, linux-mm@kvack.org
References: <Pine.LNX.4.64.0607181905140.26533@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607181905140.26533@skynet.skynet.ie>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 07:08:12PM +0100, Dave Airlie wrote:
 > 
 > AGP keeps its own copy of the protection_map, upcoming DRM changes
 > will also require access to this map from modules.

Nice. I've always disliked having this knowledge in the agp driver.
I'll queue this up.

		Dave

-- 
http://www.codemonkey.org.uk
