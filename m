Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264776AbUDWKbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbUDWKbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 06:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbUDWKbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 06:31:07 -0400
Received: from mail.enyo.de ([212.9.189.167]:53517 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264776AbUDWKbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 06:31:05 -0400
To: alex@pilosoft.com
Cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
References: <Pine.LNX.4.44.0404221030240.2738-100000@paix.pilosoft.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 23 Apr 2004 12:31:02 +0200
In-Reply-To: <Pine.LNX.4.44.0404221030240.2738-100000@paix.pilosoft.com> (alex@pilosoft.com's
 message of "Thu, 22 Apr 2004 10:37:42 -0400 (EDT)")
Message-ID: <87smevrno9.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alex@pilosoft.com writes:

> Not quite. With a SYN you have to respond with exactly the same sequence 
> number as attacking host in order to establish connection. With RST, your 
> sequence number needs to be +- rwin in order to kill the connection. That 
> significantly reduces search space.

Don't forget that you can tear down a connection by sending a SYN in
the correct window as well.

-- 
Current mail filters: many dial-up/DSL/cable modem hosts, and the
following domains: atlas.cz, bigpond.com, postino.it, tiscali.co.uk,
tiscali.cz, tiscali.it, voila.fr.
