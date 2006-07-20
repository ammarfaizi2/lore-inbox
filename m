Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWGTD7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWGTD7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 23:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWGTD7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 23:59:14 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:33033 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S932566AbWGTD7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 23:59:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAE6bvkSBTw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Shorty Porty <getshorty_@hotmail.com>
Subject: Re: [RFC][PATCH] A generic boolean
Date: Wed, 19 Jul 2006 23:59:10 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, ricknu-0@student.ltu.se
References: <BAY104-DAV11BD5C0159C7CD7BA10CA3ED610@phx.gbl>
In-Reply-To: <BAY104-DAV11BD5C0159C7CD7BA10CA3ED610@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607192359.10755.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 July 2006 23:53, Shorty Porty wrote:
> > > If this is the case, then wouldn't "long" be preferable to "int"?
> 
> Meh, it's all the same. I don't think 3 wasted CPU cycles is going to worry
> anyone too much. Hell, sometimes int IS long, though I might be wrong there.
> 

It is the _kernel_. In hot codepaths even 1 cycle matters.

-- 
Dmitry
