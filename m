Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTKTUuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 15:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTKTUuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 15:50:23 -0500
Received: from holomorphy.com ([199.26.172.102]:50864 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262009AbTKTUuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 15:50:19 -0500
Date: Thu, 20 Nov 2003 12:50:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: use ELF sections for get_wchan()
Message-ID: <20031120205015.GL22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20031118074448.GD19856@holomorphy.com> <20031120202815.GB11889@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120202815.GB11889@krispykreme>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I noticed a bunch of "FIXME: this depends on the order of these
>> functions" comments in/around wchan calculations.
>> So I decided I'd remove the dependency on the order of the functions by
>> dumping them all into an ELF section with clear delimiters.

On Fri, Nov 21, 2003 at 07:28:15AM +1100, Anton Blanchard wrote:
> I like it. At the moment wchan is next to useless because everything
> ends up in down* or something similar.

down_*() aren't covered by this yet; I'll do a sweep for that and repost.


-- wli
