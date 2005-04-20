Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVDTUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVDTUen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVDTUen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 16:34:43 -0400
Received: from smtp.nuvox.net ([64.89.70.9]:22872 "EHLO
	smtp05.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S261805AbVDTUej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 16:34:39 -0400
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
From: Dan Dennedy <dan@dennedy.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <426683E9.4080708@s5r6.in-berlin.de>
References: <20050417195706.GD3625@stusta.de>
	 <20050419191328.GJ1111@conscoop.ottawa.on.ca>
	 <1113939827.6277.86.camel@laptopd505.fenrus.org>
	 <42657F7C.8060305@s5r6.in-berlin.de>
	 <1113981989.6238.30.camel@laptopd505.fenrus.org>
	 <426683E9.4080708@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 16:32:24 -0400
Message-Id: <1114029144.5085.20.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 18:31 +0200, Stefan Richter wrote:
> Arjan van de Ven wrote:
> > On Wed, 2005-04-20 at 00:00 +0200, Stefan Richter wrote:
> >>There are users (though not in "the" kernel at the moment)
> > nor for the last 5 months... how long will it be ?
> 
> Have there been problems with the API during the past 5 months, except 
> that several kernel trees are using some parts of the API? (We are 
> actually speaking about two APIs of the ieee1394 framework.)
> 
> Which problems are solved by this patch? Do they outweigh the problems 
> it creates? The latter have been discussed. Dismissing them as Other 
> People's Problems does not nullify them.
> 
> Where is the agreed-upon, published plan for removal of features in 
> ieee1394?

Of course, there is none. In an unofficial capacity, there is just the
opinion and votes of the subsystem maintainers, extended team (e.g.,
Stefan and me), and kernel maintainers (Linus, Andrew, and Marcello).
The users are represented by the subsystem maintainers and extended
team. So, Arjan's opinion does not matter except to offer some voice of
reason.

I think I was first to raise objection upon the initial submission some
months back, and then I just observed the dialog. There are technical
merits for removal of the external symbols that I accept. I also accept
that we have no way of maintaining any sort of stable subsystem for
external projects we are not aware of or who are not communicating with
us about their requirements (it goes beyond just a stable interface).

Based upon my experience of several years on this project there is only
one external kernel module project we need to consider because that
developer has been involved and voiced requirements. That is Arne
Caspari's (The Imaging Source) DFG/1394 driver. 

I vote to remove external symbols not used by the Linux1394.org modules
or the module at http://sourceforge.net/projects/video-2-1394/
Of course, I may be voted down, but I ask the others to be realistic
about what we are arguing for (i.e. just being defensive?) and consider
the fact that there are valid reasons for their removal.


