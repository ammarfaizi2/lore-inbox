Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUENQhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUENQhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUENQhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:37:20 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:61911 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261682AbUENQhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:37:13 -0400
Date: Fri, 14 May 2004 18:36:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Will Dyson <will_dyson@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] befs i_flags thinko
Message-ID: <20040514163613.GD23863@wohnheim.fh-wedel.de>
References: <1084550848.20184.7.camel@thalience>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1084550848.20184.7.camel@thalience>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 12:07:28 -0400, Will Dyson wrote:
> 
> This was caught by Jörn Engel <joern@wohnheim.fh-wedel.de> some time
> ago. It is obviously correct. My public apologies to Jörn for delaying
> his patch.

Hey, you just uncovered a race condition, see my mail from 1min ago.
Not sure if I want to fix such a thing, though. ;)

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
