Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTKCKzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 05:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTKCKzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 05:55:48 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:11979 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262030AbTKCKzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 05:55:46 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Things that Longhorn seems to be doing right
Date: Mon, 3 Nov 2003 11:55:02 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <200311011731.10052.ioe-lkml@rameria.de> <3FA3FF46.7010309@namesys.com>
In-Reply-To: <3FA3FF46.7010309@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311031155.02293.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,
hi LKML,

On Saturday 01 November 2003 19:45, Hans Reiser wrote:
> Ingo Oeser wrote:
> >2) In a out-of-the-box Linux system its getting harder and harder to find
> >	the issuer of a search request to do the refinement.
> >
> >The latter is due to heavy asynchronity of modern user interfaces.
> >
> >I have usally several consoles, several xterms with screen in them,
> >several desktops with xterms and other programs, several X-Servers
> >running, some screen sessions attached to some virtual terminals and
> >some people even have multihead.
> >
> >Where does the refinement get sent to, without application support?

> probably looking at the DISPLAY environment variable for the relevant
> process is the right answer.

It's not always passed through, since each layer only knows the relative
issuer, but not the absolute one. And some systems just have a piece of
memory and a semaphore for notification.

This is a bit hard. Try it experimentally to get a notification done for
each leaf UI in the UI tree situation decribed above. My desktop is KDE
3.1.4, to ease your experiment.

Regards

Ingo Oeser


