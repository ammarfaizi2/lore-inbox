Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270420AbTHETFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270429AbTHETFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:05:48 -0400
Received: from holomorphy.com ([66.224.33.161]:34694 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270420AbTHETFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:05:46 -0400
Date: Tue, 5 Aug 2003 12:06:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert to static = {0}
Message-ID: <20030805190659.GT32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20030805174429.GA26933@gtf.org> <Pine.LNX.4.44.0308051949130.1849-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051949130.1849-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Jeff Garzik wrote:
>> If it's const, it shouldn't be linked into anything at all... right?

On Tue, Aug 05, 2003 at 07:51:41PM +0100, Hugh Dickins wrote:
> Sorry, Jeff, I don't get your point.

I suspect this assumes const values will get constant folded, which I'm
not sure is the case, though it certainly sounds legal and worthwhile
for a compiler to do when reasonable (i.e. for small structures and/or
extractions of small fields of const structures).


-- wli
