Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270645AbTG0Bh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 21:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270646AbTG0Bh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 21:37:57 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:45708
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270645AbTG0Bh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 21:37:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Guillaume Chazarain <gfc@altern.org>
Subject: Re: [PATCH] O9int for interactivity
Date: Sun, 27 Jul 2003 11:57:19 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <C0QOVULH73ONRLIH5282OLOWQJIF01.3f22f0ad@monpc>
In-Reply-To: <C0QOVULH73ONRLIH5282OLOWQJIF01.3f22f0ad@monpc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271157.19010.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 07:20, Guillaume Chazarain wrote:
> Hi Con,
>
> Strange your activate() function in O9. Isn't it?
> It doesn't care that much about sleep_time.
>
> So here is a very simple trouble maker.

Yes I know it's a way to make something fairly cpu intensive remain 
interactive. However since it sleeps long enough (2ms at 1000Hz is just 
enough), it doesn't bring the machine to a standstill, and is easily 
killable. I doubt it is worth working around this, but I'm open to your 
comments about variations on this theme that might be a problem.

Con

