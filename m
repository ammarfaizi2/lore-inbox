Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279605AbRJXV10>; Wed, 24 Oct 2001 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279606AbRJXV1Q>; Wed, 24 Oct 2001 17:27:16 -0400
Received: from zero.tech9.net ([209.61.188.187]:44808 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279605AbRJXV1H>;
	Wed, 24 Oct 2001 17:27:07 -0400
Subject: Re: Alsa 0.9beta8a with 2.4.{12,13} ?
From: Robert Love <rml@tech9.net>
To: harri@synopsys.COM
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD72F8F.43E21E66@Synopsys.COM>
In-Reply-To: <3BD72F8F.43E21E66@Synopsys.COM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 24 Oct 2001 17:26:42 -0400
Message-Id: <1003958804.3520.80.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-24 at 17:15, Harald Dunkel wrote:
> Up to kernel version 2.4.12 the Alsa 0.9beta8a version was working
> for my needs. Sometimes the startup script claimed that there is
> no soundcard (via686a), but after one or two restarts of this 
> script the onboard chip was detected.

The Warnings are unrelated and are because no MODULE_LICENSE tag has
been declared in each of those modules.  For each, the ALSA folks need
to put a:

	MODULE_LICENSE("GPL");

in the source.  I am assuming ALSA is GPL, and has no additional
restrictions.

I'm looking over the ChangeLog for 2.4.12->2.4.13 and I don't see
anything that sticks out as "I broke ALSA!"  The ALSA team will figure
it out.

	Robert Love

