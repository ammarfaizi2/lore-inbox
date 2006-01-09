Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWAIWla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWAIWla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWAIWla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:41:30 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:37997 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751587AbWAIWl3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:41:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OoLR6Dk5xgwgyicHbMkP1xbZDbBspkfI5lJhKXUyo3h1ydLEEY5MAYS3uO0Z89lOJF9RhwhhVygdGVuO870w15SeWwaxVdZ/mdpqeoYH8e0yFB78yuKeQnRVvCpoQgKdh+nn8py4b3iqZWZ3TSiUiUtA851dpR2MiMQfeMGSrSA=
Message-ID: <9a8748490601091441q1d6a688fr9efed06ab49dfba1@mail.gmail.com>
Date: Mon, 9 Jan 2006 23:41:28 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Edmondo Tommasina <edmondo@eriadon.com>
Subject: Re: Athlon 64 X2 cpuinfo oddities
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML List <linux-kernel@vger.kernel.org>,
       Discuss x86-64 <discuss@x86-64.org>
In-Reply-To: <200601092332.32681.edmondo@eriadon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
	 <200601092210.04186.rjw@sisk.pl>
	 <200601092332.32681.edmondo@eriadon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Edmondo Tommasina <edmondo@eriadon.com> wrote:
> On Monday 09-January-2006 22:10, Rafael J. Wysocki wrote:
> > Hi,
> >
>
> Same here. cpu cores is 2.
>
> Random try: Do you have CONFIG_NR_CPUS=2 in your config?
>
Yup.

$ zcat /proc/config.gz | grep NR_CPUS
CONFIG_NR_CPUS=2

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
