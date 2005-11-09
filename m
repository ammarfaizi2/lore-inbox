Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965305AbVKIIP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbVKIIP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbVKIIP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:15:58 -0500
Received: from holomorphy.com ([66.93.40.71]:18618 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S965305AbVKIIP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:15:58 -0500
Date: Wed, 9 Nov 2005 00:14:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       dipankar@hill9.org
Subject: Re: [PATCH] tasklist-RCU fix in attach_pid()
Message-ID: <20051109081425.GI29402@holomorphy.com>
References: <20051109032233.GA3060@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109032233.GA3060@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 07:22:34PM -0800, Paul E. McKenney wrote:
> Bug in attach_pid() can result in RCU readers in find_pid() getting
> confused if they race with process creation.
> Signed-off-by: <paulmck@us.ibm.com>

Simple enough.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
