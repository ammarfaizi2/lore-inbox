Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUJQTBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUJQTBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbUJQTBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:01:08 -0400
Received: from holomorphy.com ([207.189.100.168]:35225 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268254AbUJQTBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:01:04 -0400
Date: Sun, 17 Oct 2004 12:00:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       luc@saillard.org, Andrew Morton <akpm@osdl.org>
Subject: Re: rc4-mm1 and pwc-unofficial: kernel BUG and scheduling while atomic [u]
Message-ID: <20041017190054.GB5607@holomorphy.com>
References: <20041017073614.GC7395@gamma.logic.tuwien.ac.at> <20041017093018.GY5607@holomorphy.com> <1098038131.15115.8.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098038131.15115.8.camel@nosferatu.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 02:30 -0700, William Lee Irwin III wrote:
>> You need to right shift the argument by PAGE_SHIFT.

On Sun, Oct 17, 2004 at 08:35:31PM +0200, Martin Schlemmer [c] wrote:
> I am trying to get vesafb-tng to work with rc4-mm1, but are not sure
> when to shift the argument by PAGE_SHIFT, and when not to.  The patches
> from you in rc4-mm1 sometimes shifts the second arg, other times the
> third, and other times not at all.  Is there a easy way for a mostly
> clueless person to figure out when to shift what argument and when not?

Please point out where these inconsistencies occur and I will repair
them.

Only the third argument changed, from a physical address to a pfn.


-- wli
