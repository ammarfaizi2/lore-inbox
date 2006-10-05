Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWJEQMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWJEQMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWJEQMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:12:12 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:21473 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932171AbWJEQMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:12:10 -0400
Date: Thu, 5 Oct 2006 18:12:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tony Finch <dot@dotat.at>
Cc: David Woodhouse <dwmw2@infradead.org>, Dennis Heuer <dh@triple-media.com>,
       linux-kernel@vger.kernel.org
Subject: Re: sunifdef instead of unifdef
Message-ID: <20061005161200.GA20099@uranus.ravnborg.org>
References: <20061005150816.76ca18c2.dh@triple-media.com> <1160059253.26064.69.camel@pmac.infradead.org> <Pine.LNX.4.64.0610051648200.28237@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610051648200.28237@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't received any contributions to unifdef in the last 18 months
> which is why it hasn't changed.
Reminds me - I did a small change to avoid dependency on strlcpy.

You can see it here:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=14a036d2dc304797f3624c06bd6d2a1e9b59e45a

I strongly preferred 8 simple codelines as replacement for carrying
strlcpy in a seperate file. Feel free to include this in your unifdef
as you whish.

	Sam
