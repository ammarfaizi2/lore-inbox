Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTIKRMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbTIKRMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:12:15 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50065 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261413AbTIKRMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:12:12 -0400
Date: Thu, 11 Sep 2003 18:12:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030911171205.GH29532@mail.jlokier.co.uk>
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73oexri9kx.fsf@oldwotan.suse.de> <20030911162504.GL21596@parcelfarce.linux.theplanet.co.uk> <20030911183136.01dfeb53.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911183136.01dfeb53.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Even a memory write is tens to hundres of cycles.

Not from the CPU's perspective.  It is done in parallel with other
instructions.

-- Jamie
