Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTENNXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTENNXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:23:18 -0400
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:5897
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id S262063AbTENNXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:23:17 -0400
Date: Wed, 14 May 2003 09:35:57 -0400 (EDT)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: FW: am-utils or kernel bug ? Seems to be kernel or glibc bug...
In-Reply-To: <1052900861.24411.121.camel@atlas.inria.fr>
Message-ID: <Pine.LNX.4.44.0305140933120.28685-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2003, Nicolas Turro wrote:

> You were right, Ion,
> switching to a RH8 kernel ( 2.4.18-14 ) , solved the issue. I cannot
> reproduce this futex bug on the father process...
> 
> Who should i contact in order to correct things ?

bugzilla.redhat.com is a good first start.

Hmm. I just realized that I was also running my script on a plain vanilla 
2.4.20 kernel, NOT rh9's own kernel, so that's probably why I couldn't 
reproduce the problem. I'll try again tonight, but as you said this points 
strongly towards some new RH kernel feature which is less than stable or 
which modifies certain semantics in ways that occasionally break amd.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

