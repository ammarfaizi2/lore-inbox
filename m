Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVANVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVANVuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVANVtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:49:18 -0500
Received: from opersys.com ([64.40.108.71]:37895 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262195AbVANVqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:46:45 -0500
Message-ID: <41E83F84.7080102@opersys.com>
Date: Fri, 14 Jan 2005 16:54:12 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 2/8 ] ltt for 2.6.10 : core headers
References: <41E76279.5020507@opersys.com> <20050114205507.GD8385@mars.ravnborg.org>
In-Reply-To: <20050114205507.GD8385@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Sam,

Sam Ravnborg wrote:
> include/linux/*.h is supposed to include only definitions used by other
> parts of the kernel.
> Definitions used only internally by ltt shall stay in kernel/
> 
> This is generally agreed upon, but not yet common practice.

Should there be a kernel/ltt-core.h or should I just put all required
definitions in kernel/ltt-core.c? The latter would result in a
cluttered C file, I think. Though there aren't any .h's in kernel/,
so I'm not sure what's the best way to proceed here.

> Btw. did you run it through sparse?
> Not that I found something, but did not see sparse annotation at first
> sight.

No I haven't. I've added it to my to-do list.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
