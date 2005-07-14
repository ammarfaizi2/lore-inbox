Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVGNQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVGNQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGNQ0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:26:54 -0400
Received: from 37.195.62.64.in-arpa.com ([64.62.195.37]:2829 "EHLO
	bniemczyk.is-a-geek.com") by vger.kernel.org with ESMTP
	id S262205AbVGNQ0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:26:37 -0400
Subject: Re: About a change to the implementation of spin lock in 2.6.12
	kernel.
From: Brandon Niemczyk <brandon@snprogramming.com>
Reply-To: brandon@snprogramming.com
To: multisyncfe991@hotmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl>
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl>
	 <20050714051653.GP8907@alpha.home.local>
	 <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl>
Content-Type: text/plain
Organization: SN Programming
Date: Thu, 14 Jul 2005 12:26:38 -0400
Message-Id: <1121358399.4685.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2nb1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 09:21 -0700, multisyncfe991@hotmail.com wrote:
> Hi Willy,
> 
> I think at least I can remove the LOCK instruction when the lock is already 
> held by someone else and enter the spinning wait directly, right?
If the lock is already held by someone else, the cpu is just going to
burn cycles until it's not. So why do you care?

-- 
Brandon Niemczyk

