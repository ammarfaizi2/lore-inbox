Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129452AbRBVNZR>; Thu, 22 Feb 2001 08:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBVNZG>; Thu, 22 Feb 2001 08:25:06 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:11013 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129106AbRBVNYv>;
	Thu, 22 Feb 2001 08:24:51 -0500
To: Markus Germeier <mager@tzi.de>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
In-Reply-To: <94ae7g9o8t.fsf@religion.informatik.uni-bremen.de> <E14VZCs-00023R-00@the-village.bc.nu> <14996.14604.348038.42765@pizda.ninka.net> <948zmy97zc.fsf@religion.informatik.uni-bremen.de>
From: Jes Sorensen <jes@linuxcare.com>
Date: 22 Feb 2001 14:22:19 +0100
In-Reply-To: Markus Germeier's message of "22 Feb 2001 14:12:55 +0100"
Message-ID: <d3y9uyj1is.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Markus" == Markus Germeier <mager@tzi.de> writes:

Markus> Tell me if I can provide you with further data to nail down
Markus> this bug.

Alan forwarded a patch to me from DaveM which fixed it for me.

Markus> Jes: I thought about your information that ssh connections do
Markus> not show this problem. I believe you are using ssh 2.3 or 2.4
Markus> from ssh.com, right? 2.3 introduced a rekeying-feature which
Markus> exchanges new keys every 60 minutes, so the TCP keepalive is
Markus> never triggered. (Due to a bug which is still present in 2.4,
Markus> we can't use these versions at my site.)

No way, I don't use software from those slimeballs, I use OpenSSH.

The problems I were seeing were much more than every 2 hrs, more like
every 10-15 mins. Anyway it seems it got fixed.

Jes
