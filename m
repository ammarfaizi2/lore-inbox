Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWJCRab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWJCRab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWJCRab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:30:31 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:43280 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1030345AbWJCRaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:30:30 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Spam, bogofilter, etc
Date: Tue, 3 Oct 2006 19:32:13 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <1159539793.7086.91.camel@mindpipe> <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain>
In-Reply-To: <1159811392.8907.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031932.13125.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> every good spammer reruns their message through spamassassin adding random
> text till they get a good score *then* they spew it out.

That's a flaw in the whole idea of having pre-defined (by human) separate 
rules catching misc obvious (to us) spam indicators. If you had a filter that 
you just feed with raw data from many sources and that does pattern 
recognition and learns on its own, there (probably) would be no way to go 
around it. At least it wouldn't be easy. In fact i.e. when ANN is used as 
classifier, the rules created after training are hidden and have no obvious 
represantation to us so one would have no idea what to change to get the 
desired filter output.

	Mariusz
