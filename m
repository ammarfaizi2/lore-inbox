Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTE0TJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTE0TJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:09:18 -0400
Received: from holomorphy.com ([66.224.33.161]:21737 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263619AbTE0TJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:09:17 -0400
Date: Tue, 27 May 2003 12:20:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
Message-ID: <20030527192044.GP8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <200305272104.05802.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272104.05802.m.c.p@wolk-project.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 09:05:45PM +0200, Marc-Christian Petersen wrote:
> Hi Marcelo,
> attached patch fixes the oom killer braindamage where it tries to kill 
> processes again and again and again w/o any ending or successfull killing of 
> the selected processes in an OOM case.
> The attached, very simple but effective, patch fixes it.
> All the kudos go to Rik van Riel.
> Patch tested and works, and also for a long time in my tree (and maybe also 
> others?!)
> This issue is out there for several years.
> Please consider it for 2.4.21-rc5, thanks.
> ciao, Marc

Also in 2.5.x for some time.


-- wli
