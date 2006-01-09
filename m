Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWAISoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWAISoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWAISoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:44:22 -0500
Received: from smtp11.wanadoo.fr ([193.252.22.31]:40469 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S1030246AbWAISoV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:44:21 -0500
X-ME-UUID: 20060109184420193.2F3741C0004D@mwinf1103.wanadoo.fr
Subject: Re: [PATCH] It's UTF-8
From: Xavier Bestel <xavier.bestel@free.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m3ek3hhbs0.fsf@defiant.localdomain>
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
	 <43C21E9D.3070106@gmail.com>  <m3ek3hhbs0.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 09 Jan 2006 19:44:26 +0100
Message-Id: <1136832266.10433.1.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 09 janvier 2006 à 12:38 +0100, Krzysztof Halasa a écrit :
> "Alexander E. Patrakov" <patrakov@gmail.com> writes:

> > FAT: this is not the recommended filesystem for use with UTF-8 filenames.
> >
> > Reason: the utf8 IO charset is the only IO charset that displays
> > filenames properly in UTF-8 locales. So the choice is really between
> > case-sensitive filenames (iocharset=utf8) and completely unreadable
> > filenames (everything else).
> 
> And UTF-8 locale seems to be the only really sane today. I'd kill the
> whole warning.

.. on unix. But FAT is a sort of lingua franca of filesystems, and is
the only one understandable by every (embedded) OS. So you'd better stay
compatible with everyone else.

	Xav


