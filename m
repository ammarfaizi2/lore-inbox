Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUGAOuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUGAOuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbUGAOuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:50:25 -0400
Received: from mail.shareable.org ([81.29.64.88]:63917 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265693AbUGAOuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:50:22 -0400
Date: Thu, 1 Jul 2004 15:50:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701145004.GA5114@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com> <20040701041158.GE1564@mail.shareable.org> <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com> <20040701123941.GC4187@mail.shareable.org> <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> >The error code is -1, aka. MAP_FAILED.
> Oops!  I guess I was just lucky that part didn't fail :-D On the
> other hand, it couldn't legally return 0 anyway, could it?

Yes it could -- if you request a mapping at address 0 with MAP_FIXED.
A few OSes won't do that, but Linux and many others will.

-- Jamie
