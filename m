Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbUCPBwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbUCPBuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:50:07 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:62706 "EHLO
	mail-out3.apple.com") by vger.kernel.org with ESMTP id S263422AbUCPBqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:46:51 -0500
Date: Mon, 15 Mar 2004 17:46:44 -0800
Subject: Re: [PATCH] fix warning about duplicate 'const'
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: Richard Henderson <rth@twiddle.net>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
To: Linus Torvalds <torvalds@osdl.org>
From: Mike Stump <mrs@apple.com>
In-Reply-To: <Pine.LNX.4.58.0403100740120.1092@ppc970.osdl.org>
Message-Id: <C755F5DF-76EB-11D8-B0DE-003065A77310@apple.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 10, 2004, at 07:43 AM, Linus Torvalds wrote:
> What the code _really_ wants to do is to just compare two types for 
> being basically equal, and in real life what Linux really would prefer 
> is to have "types" as first-class citizens and being able to compare 
> them directly instead of playing games.

:-)  Gosh, it sounds so sensible and easy.  Maybe someone will hammer 
on the std C folks for the feature...

