Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWJBUpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWJBUpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWJBUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:45:22 -0400
Received: from zakalwe.fi ([80.83.5.154]:7133 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S964985AbWJBUpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:45:21 -0400
Date: Mon, 2 Oct 2006 23:44:25 +0300
From: Heikki Orsila <shd@zakalwe.fi>
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-ID: <20061002204425.GC24539@zakalwe.fi>
References: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200610021858.k92IwXJg011184@olwen.urbana.css.mot.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 01:58:33PM -0500, Scott E. Preece wrote:
> It also helps with static analysis tools.

I'd say those analysis tools are pretty useless if they can not handle 
trivial cases like this.

> CodingStyle seems to
> be silent on the point, but points to Kernighan and Ritchie, who say
> "These initializations are actually unnecessary, since all are zero, but
> it's a good idea to make them explicit anyway."

It was a local variable. They are not autoinitialised. Are you perhaps 
mixing this with statics and globals?

- Heikki
