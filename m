Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTFGAeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFGAeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:34:16 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:53642 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262430AbTFGAeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:34:14 -0400
Message-Id: <200306070047.h570lfsG003377@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 21:06:20 -0300."
             <20030606210620.G3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 20:45:51 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606210620.G3232@almesberger.net>,Werner Almesberger writes:
>TCP connections will survive route changes, interface
>removals, etc.

really?  if i remove my ethernet interface i expect all the
connections to die.
