Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbTEHIZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbTEHIZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:25:36 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:64785 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261210AbTEHIZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:25:35 -0400
Date: Thu, 8 May 2003 10:22:52 +0200
From: DervishD <raul@pleyades.net>
To: Glenn McGrath <bug1@optushome.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] set argv[0] of init process to filename
Message-ID: <20030508082252.GG68@DervishD>
References: <20030508145412.5d98ba5c.bug1@optushome.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030508145412.5d98ba5c.bug1@optushome.com.au>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Glenn :)

* Glenn McGrath <bug1@optushome.com.au> dixit:
> This current behaviour is inconvenient for busybox
> (www.busybox.net) as it uses argv[0] to determine functionality.

    I had a similar problem with my init clone (a virtual console
init+getty+login for embedded systems) with the same issue. I wanted
to change the argv[0] for spawned processes for chaging the name that
the ps command will show. At the end I assumed that the shortest name
possible was 'init' and that I had four characters at least... If the
space is shorter, less characters are used.

> The attached patch against 2.4.20 sets argv[0] to the filename
> being run as the init process, it results in marginally smaller
> binary (12 bytes).

    IMHO this is a good thing, I hope it gets included, since in the
general case it won't do any harm (IMHO, again). Let's see what says
Marcelo.

> Is there a reason why argv[0] should always be set to "init" ?

    Don't know :??

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
