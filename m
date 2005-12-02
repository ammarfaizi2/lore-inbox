Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVLBMt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVLBMt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 07:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVLBMt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 07:49:59 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:11379 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750721AbVLBMt6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 07:49:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hW4L3ZXvcyyK4Z3eB3Z0qCAE6/2gt3/fGBsF4vvAED6nRMlqLXw520SIlbcHqs9ozFXPMLiGFSod/2nSQ3VPlTf6PwknyP/oifCE5+0wRzXzVbWObJWPfX82QOk/g2MZva5Le0uLOT0kVQlBYcKm7FOEPLygX9WBfNRf/BfCDJo=
Message-ID: <9611fa230512020449g2573ea55qd6d780b750eb773c@mail.gmail.com>
Date: Fri, 2 Dec 2005 12:49:55 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <9611fa230512011242p526b5128ub2918a3fa48da10c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	 <1132917564.7068.41.camel@laptopd505.fenrus.org>
	 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	 <1133092701.2853.0.camel@laptopd505.fenrus.org>
	 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
	 <20051127165733.643d5444.akpm@osdl.org>
	 <9611fa230511291357g3aa964adj6918fea50f5ee66e@mail.gmail.com>
	 <20051129151044.7ce3ef4a.akpm@osdl.org>
	 <9611fa230512011242p526b5128ub2918a3fa48da10c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/05, Tarkan Erimer <tarkane@gmail.com> wrote:
> On 11/29/05, Andrew Morton <akpm@osdl.org> wrote:
> > Please generate the sysrq-T trace when the system hangs.
>
> I tried sysrq-T trace. But, When hit the bug, system completely freezes.
> Alt+sysrq+t (Normally Alt+sysrq+t works perfectly) or any other
> combination does not respond. Is there any other way to trace  this?
> Also, I will try just-released 2.6.15-rc4 and let know the result.

Today, I tried 2.6.15-rc4. The result is same. Still hangs,
Alt+sysrq+t does not respond and there is nothing related to the issue
in syslog.
