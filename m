Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264761AbUDWIhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264761AbUDWIhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUDWIhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:37:24 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:34826 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264761AbUDWIhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:37:22 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: nvidia binary driver broken with 2.6.6-rc{1,2}, reverting a -mm patch makes it work
Date: Fri, 23 Apr 2004 10:37:09 +0200
User-Agent: KMail/1.6.2
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       Rik van Ballegooijen <sleightofmind@xs4all.nl>
References: <4088D1E3.1050901@xs4all.nl> <20040423083041.GK8599@charite.de>
In-Reply-To: <20040423083041.GK8599@charite.de>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404231037.09329@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 10:30, Ralf Hildebrandt wrote:

Hi Ralf,

> > Because of a patch from -mm merged in mainstream i cannot get the nvidia
> > binary to work with the 2.6.6 release candidates. I get this message
> > when doing `modprobe nvidia`:

> $ uname -a
> Linux hummus2 2.6.6-rc2-bk1 #1 Thu Apr 22 14:15:08 CEST 2004 i686
> GNU/Linux
> nvidia works like a charm here.

that's the problem. It works for many people, for many others not. It always 
worked fine for me too but I had to rip that out of my 2.6-WOLK tree to 
satisfy all people using wolk and lack of knowledge to fix that by myself.

ciao, Marc
