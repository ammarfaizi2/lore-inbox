Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTIHKfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 06:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTIHKfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 06:35:12 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:26125 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S262136AbTIHKfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 06:35:09 -0400
Date: Mon, 8 Sep 2003 03:34:16 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: Michael Still <mikal@stillhq.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] bk chmod needed for scripts/*
Message-ID: <20030908103415.GA12937@net-ronin.org>
References: <20030907215953.GA11020@net-ronin.org> <Pine.LNX.4.44.0309081327420.20775-100000@diskbox.stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309081327420.20775-100000@diskbox.stillhq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:28:32PM +1000, Michael Still wrote:
> Yes, but most of them do a:
> 
> 	$(PERL) ./scripts/foo
> 
> Which removes the need for the executable bit (for the makefiles at 
> least). Is there a specific problem you're having?

I tend to run many of the stuff in there manually instead through the
makefiles.

Also, the docbook generation failed due to that as well via the
'make pdfdocs' target.

-- DN
Daniel
