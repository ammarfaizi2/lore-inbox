Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272566AbTHJICq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272568AbTHJICp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:02:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3339 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S272566AbTHJICo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:02:44 -0400
Date: Sun, 10 Aug 2003 10:02:13 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, jamie@shareable.org, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030810080213.GD29616@alpha.home.local>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810072945.GA14038@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 09:29:45AM +0200, Willy Tarreau wrote:
>   likely => __builtin_expect(!(x), 0)

hmmm silly me, forget it, it will return the opposite. We should use !!(x),1.

Willy

