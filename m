Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTDOSF1 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTDOSF1 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:05:27 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:8944 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S262186AbTDOSF1 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 14:05:27 -0400
Date: Tue, 15 Apr 2003 20:17:48 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030415181748.GB27227@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20030414190032.GA4459@kroah.com> <200304142209.56506.oliver@neukum.org> <20030414203328.GA5191@kroah.com> <200304142311.01245.oliver@neukum.org> <3E9B2720.7020803@cox.net> <1050356754.3664.82.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050356754.3664.82.camel@localhost>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 05:45:54PM -0400, Robert Love wrote:
> I spent the weekend reading about it and I spoke with some of the d-bus
> hackers.
> 
> It is really neat and certainly something we should look into.
> 
> See http://www.freedesktop.org/software/dbus/

This is way too complicated.

It's a message protocol that resembles XDR. The messages are also binary
instead of ASCII. Bah. If one would want to subscibe to a small selection
of events then the usual filesystem provides a much better concept. For
example, a /proc/kernel/event tree.

-- 
Frank
