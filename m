Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbUB2Siz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 13:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUB2Siz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 13:38:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262101AbUB2Sit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 13:38:49 -0500
Message-ID: <404231AC.9090307@pobox.com>
Date: Sun, 29 Feb 2004 13:38:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] unsafe reset in ac97_codec.c
References: <1075822947.5204.506.camel@cearnarfon>	 <40216306.2010602@pobox.com>  <1075998717.5204.1003.camel@cearnarfon>	 <1076003988.15801.8.camel@dhcp23.swansea.linux.org.uk> <1077810934.2846.187.camel@cearnarfon>
In-Reply-To: <1077810934.2846.187.camel@cearnarfon>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks good to me.

You need to use bit operations, not equality, to check codec->flags, but 
I can fix that up.

	Jeff




