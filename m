Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263315AbUDUQIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUDUQIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUDUQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:08:35 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:53413 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S263315AbUDUQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:08:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
In-Reply-To: <1N4qh-4Ct-13@gated-at.bofh.it>
References: <1N4qh-4Ct-13@gated-at.bofh.it>
Date: Wed, 21 Apr 2004 18:08:14 +0200
Message-Id: <E1BGKGk-0005zP-00@lanczos.pci.uni-heidelberg.de>
From: Frank Otto <Frank.Otto@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Steffl <steffl@bigfoot.com> wrote:
:    it looks that after update to 2.6.5 kernel (debian source package but 
: I guess it would be the same with stock 2.6.5) the mouse wheel and side 
: button on Logitech Cordless MouseMan Wheel mouse do not work.
:
: [snip]
:
:    BTW X windows is confused in the same way (I guess because that's 
: what it gets from kernel driver - using xev I found that it thinks the 
: sidebutton is button 2 and that turning the wheel is not an event at all).

What worked for me is to make a change to my XF86Config:
use /dev/psaux for the mouse device, and choose "ExplorerPS/2"
for the mouse protocol (I previously used "MouseManPlusPS/2").

HTH,
Frank

[Sorry if this post falls out of its thread, I'm not subscribed to
LKML and only read it via the newsgroup interface but that currently
doesn't allow posting.]
