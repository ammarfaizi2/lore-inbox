Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265548AbUGDMSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUGDMSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUGDMSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:18:22 -0400
Received: from pra68-d183.gd.dial-up.cz ([193.85.68.183]:12928 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S265548AbUGDMSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:18:07 -0400
Date: Sun, 4 Jul 2004 14:17:40 +0200
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: register dump when press scroll lock
Message-ID: <20040704121740.GA3637@penguin.localdomain>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
References: <20040703102516.GA11284@penguin.localdomain> <200407040219.32581.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407040219.32581.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040523i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:19:32AM +0300, Denis Vlasenko wrote:
> On Saturday 03 July 2004 13:25, Marcel Sebek wrote:
> > I run 2.6.7 kernel.
> >
> > Steps to reproduce:
> > Switch keyboard by "Pause/Break" key from English to Czech map (or another
> > second keymap, I also tried Slovak). Then press scrolllock. The following
> > is printed out and scrlock led state is untouched:
> 
> A bug in keyboard utils? (most probably Czech map isn't correct)
> Which keyboard utils do you use?
> 

I'm using Debian testing.

I looked at keymap definition. For ScrLock there is this:

keycode 70 = Scroll_Lock Show_Memory Show_Registers
control keycode 70 = Show_State
alt keycode 70 = Scroll_Lock

If I want the same behavior as with english keymap, I should either
use Alt-ScrLock or rewrite the keymap.

Thanks for your time.

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

