Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272255AbTHDV13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTHDV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:27:28 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:61846
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272255AbTHDV1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:27:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Antonio Vargas <wind@cocodriloo.com>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 07:32:24 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308050207.18096.kernel@kolivas.org> <20030804191513.GB814@wind.cocodriloo.com>
In-Reply-To: <20030804191513.GB814@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308050732.24942.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 05:15, Antonio Vargas wrote:
> On Tue, Aug 05, 2003 at 02:07:18AM +1000, Con Kolivas wrote:
> > +	if (!p->activated){

This is the relevent branch.

> Con, I will probably be wrong, but in [1] you are testing
> "activated != 0" and [2] is setting "activated = -1", which
> _is_ != 0 and thus would enter the "if->else" branch and
> do "activated = 1" in [3].
>
> Perhaps you meant to set "activated = 0" in [2]???

It looks for activated == 0 to decide if it should enter the branch and set it 
to either 1 or 2.

> Note I've not read the rest of the scheduler code,
> so perhaps the "activated = 0" is in another place...
> just in case, I prefer asking.

Never hurts.

Con

