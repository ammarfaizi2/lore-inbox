Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVEIWPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVEIWPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 18:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVEIWPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 18:15:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35578 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261544AbVEIWPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 18:15:46 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1115674190.16017.32.camel@dhcp153.mvista.com>
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407>
	 <427C6D7D.878935F1@tv-sign.ru> <20050509073043.GA12976@elte.hu>
	 <427F1A99.58BCCB88@tv-sign.ru>  <20050509091133.GA25959@elte.hu>
	 <1115662430.16016.4.camel@dhcp153.mvista.com>
	 <1115666506.15027.3.camel@localhost.localdomain>
	 <1115674190.16017.32.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1115676933.16016.49.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2005 15:15:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 14:29, Daniel Walker wrote:

> 
> It's a typo , I mean rt_mutex->wait_list . Sorry .. The list part is a
> list head , which is two pointers. We could condense that to one
> pointer, and it eliminates the overhead of the structure we use .. Below
> seems to work, but consider it an rfc patch.

That last patch misses the first guy on the wait_list , but I think we
could work around that somehow ..

Daniel

