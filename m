Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTFYQDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTFYQDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 12:03:34 -0400
Received: from mail.convergence.de ([212.84.236.4]:61363 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264667AbTFYQDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 12:03:33 -0400
Message-ID: <3EF9CB25.4050105@convergence.de>
Date: Wed, 25 Jun 2003 18:17:41 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
References: <20030625150629.GA1045@mars.ravnborg.org> <20030625160830.A19958@infradead.org> <20030625154223.GB1333@mars.ravnborg.org>
In-Reply-To: <20030625154223.GB1333@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

> For the dvb case, the .h files are used by files located in:
> dvb/frontends
> dvb/ttpci

Just to get things straight:
Current header files, which must be present for user space
applications, are located in include/linux.

The internal header files for the dvb-core are in
drivers/media/dvb/dvb-core.

These are accessed by drivers/media/dvb/frontends for example,
this is true.

 > Therefore I suggested linux/media.

There is no particular reason that they must stay there, so
I suggest that I move them to include/dvb just like hch said.

> 	Sam

If this is ok, I'll do this with the next patchset.

CU
Michael.


