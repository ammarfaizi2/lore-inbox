Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTLJNWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTLJNWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:22:24 -0500
Received: from head.linpro.no ([80.232.36.1]:29072 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id S263189AbTLJNWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:22:22 -0500
Subject: Re: 2.4: mylex and > 2GB RAM
From: Per Buer <perbu@linpro.no>
Reply-To: perbu@linpro.no
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0312090830270.1289-100000@logos.cnet>
References: <Pine.LNX.4.44.0312090830270.1289-100000@logos.cnet>
Content-Type: text/plain
Organization: Linpro AS
Message-Id: <1071062497.32441.20.camel@netstat.linpro.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 10 Dec 2003 14:21:37 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AU4I9-0004wg-GP*nZ6SjmYSxF6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

On Tue, 2003-12-09 at 11:31, Marcelo Tosatti wrote:
> 
> You may want to give 2.4.23 a try. 
> 
> The VM has been changed to balance the memory in a "saner" way wrt 
> highmem. 

All I can say is that it is somewhat better - but far from good. When
writing intensively prosesses more or less lock up when we run out of
Lowmem. 

2.4.23 seems to recover from this state faster then 2.4.22 - but I cant
really quantify this in any way.

-- 
There are only 10 different kinds of people in the world,
those who understand binary, and those who don't.


