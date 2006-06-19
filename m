Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWFSWEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWFSWEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWFSWEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:04:08 -0400
Received: from mailfe09.tele2.fr ([212.247.155.12]:11946 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S964935AbWFSWEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:04:07 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Tue, 20 Jun 2006 00:03:59 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060619220359.GA6218@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <20060618213342.GG13255@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060618213342.GG13255@w.ods.org>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Willy Tarreau, le Sun 18 Jun 2006 23:33:42 +0200, a écrit :
> I too am used to starting with init=/bin/sh, but I'm also used to launch
> ping in the background. However, if getting Ctrl-C working implies a risk
> of killing init, then I'd rather keep it the old way.

Maybe you should rather use init=/bin/login . If your login program is
smart enough, it will set a session and thus ^C will work.

Samuel
