Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUJQSWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUJQSWv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUJQSWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:22:50 -0400
Received: from holomorphy.com ([207.189.100.168]:20889 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269261AbUJQSWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:22:43 -0400
Date: Sun, 17 Oct 2004 11:22:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, luc@saillard.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: rc4-mm1 and pwc-unofficial: kernel BUG and scheduling while atomic
Message-ID: <20041017182238.GA5607@holomorphy.com>
References: <20041017073614.GC7395@gamma.logic.tuwien.ac.at> <20041017093018.GY5607@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017093018.GY5607@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 09:36:14AM +0200, Norbert Preining wrote:
>> the module compiled and loaded without problem, but when starting
>> gnomemeeting I get the following kernel BUG and scheduling while atomic:

On Sun, Oct 17, 2004 at 02:30:18AM -0700, William Lee Irwin III wrote:
> You need to right shift the argument by PAGE_SHIFT.

We have handled this further in private email and Norbert now has
a working port of his driver.


-- wli
