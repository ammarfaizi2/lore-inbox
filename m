Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTJ3KJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTJ3KJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:09:42 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:22434 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262327AbTJ3KJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:09:35 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: trelane@digitasaru.net
Subject: Re: Things that Longhorn seems to be doing right
Date: Thu, 30 Oct 2003 10:23:32 +0100
User-Agent: KMail/1.5.4
References: <3F9F7F66.9060008@namesys.com> <20031030015212.GD8689@thunk.org> <20031030020317.GE3094@digitasaru.net>
In-Reply-To: <20031030020317.GE3094@digitasaru.net>
MIME-Version: 1.0
Content-Disposition: inline
Cc: "Theodore Ts'o" <tytso@mit.edu>, Erik Andersen <andersen@codepoet.org>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Message-Id: <200310301019.35568.ioe-lkml@rameria.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 October 2003 03:03, Joseph Pingenot wrote:
> Actually, thinking about it, it's ideal to have as a pluggable userspace
>   daemon: on open() or a little after, determine the filetype, and forward
>   interactions to a module/plugin that knows how to deal with that
>   data format.  The plugin then calls some under-process (either back to
>   the daemon or some other thing) to then archive off the information.

Sounds a little bit like the STREAMS interface.

You could also have a wrapper around your own open() which can do more.
But sth. like you suggest is done by KDE already internally (and Gnome maybe
too),


