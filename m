Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWEUPek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWEUPek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 11:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWEUPek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 11:34:40 -0400
Received: from mail.linicks.net ([217.204.244.146]:24547 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S964882AbWEUPek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 11:34:40 -0400
From: Nick Warne <nick@linicks.net>
To: George Nychis <gnychis@cmu.edu>
Subject: Re: cannot load *any* modules with 2.4 kernel
Date: Sun, 21 May 2006 16:34:35 +0100
User-Agent: KMail/1.9.1
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <446F3F6A.9060004@cmu.edu> <7c3341450605210032j9eb3da6y5f307a3198957214@mail.gmail.com> <44707C9D.1070606@cmu.edu>
In-Reply-To: <44707C9D.1070606@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605211634.35373.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 May 2006 15:43, George Nychis wrote:
> Before I build i do:
> PATH=/usr/local/modutils/sbin:$PATH
>
> Therefore it must be reading it first, sorry I should have mentioned
> this... just have done so much to try and get it to work I can't
> remember it all :)

Well, yes, but as soon as you reboot and login that $PATH will be lost - you 
need to add that in your .bashrc, or profile.d/ or whatever to make it 
permanent.

I don't know what the issue is with the modules, but building against one 
version of modutils and then running system with another version will surely 
cause problems?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
