Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWJMPpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWJMPpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWJMPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:45:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51917 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751322AbWJMPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:45:09 -0400
Subject: Re: [PROBLEM] ATI IXP - Unknown symbol -> no sound
From: Lee Revell <rlrevell@joe-job.com>
To: neologix@free.fr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1160751687.452faa4742f00@imp5-g19.free.fr>
References: <1160751687.452faa4742f00@imp5-g19.free.fr>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 11:46:04 -0400
Message-Id: <1160754364.4201.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 17:01 +0200, neologix@free.fr wrote:
> Hello.
> 
> short:
> [2.6.18] ATI IXP - Unknown symbol -> no sound
> 
> longer:
> I have an ATI IXP sound card, and since kernel 2.6.17, sometimes I have no sound
> when I boot.
> The card dosn't appear in /proc/asound/cards
> 
> The relevant log part are given below
> What is weird is that the modules are loaded, and that it doesn't happen
> everytime.
> I have a P4 with hyperthreading enabled (I don't know if it plays a part).
> The thing is that before 2.6.17, I never had problems

Sounds like your ALSA modules were built against a different kernel.

Lee

