Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWKMSSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWKMSSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWKMSSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:18:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:53881 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932638AbWKMSSJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:18:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JukDNDydXjt2aG1Kib9r4s6t36d1wLSH8HlqD8jGarQVhZhafZZPsNhPG5x8RtBOUWdR1WzLngNnHQJ+Txao4Adhb7N6bAJ4JapU2xsPwcrlo3Z6/NN9K/ZRUN+34x3lJ7Pa5PIG49u8rVPrhDPJXJjwct2sL5bc+tAYMimJwdg=
Message-ID: <d120d5000611131018x5d018d4as22eff4fac409b0c5@mail.gmail.com>
Date: Mon, 13 Nov 2006 13:18:07 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] Apple Motion Sensor driver
Cc: "Stelian Pop" <stelian@popies.net>,
       "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       "Andrew Morton" <akpm@osdl.org>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Paul Mackerras" <paulus@samba.org>, "Robert Love" <rml@novell.com>,
       "Rene Nussbaumer" <linux-kernel@killerfox.forkbomb.ch>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       nicolas@boichat.ch
In-Reply-To: <20061113191115.fa5c5d6f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <20061111214143.GA25609@hansmi.ch>
	 <1163282417.32084.18.camel@localhost.localdomain>
	 <20061112083705.GB25609@hansmi.ch>
	 <1163367528.21258.2.camel@localhost.localdomain>
	 <20061113191115.fa5c5d6f.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Jean Delvare <khali@linux-fr.org> wrote:
> Stelian,
>
> On Sun, 12 Nov 2006 22:38:47 +0100, Stelian Pop wrote:
> > Le dimanche 12 novembre 2006 à 09:37 +0100, Michael Hanselmann a écrit :
> > [...]
> >
> > > But since Nicolas is really busy since months, I'd say the submitted
> > > code can go in. I'll then make a patch which adds the class.
> >
> > Ok, cool, let's get it in then.
> >
> > Who picks it up ? Jean ? Andrew ?
>
> Depends to the answer to my question elsewhere in this thread. If we
> decide that the accelerometer class and drivers belong to hwmon, I'll
> take the patch (well it'll need to be submitted and reviewed first
> anyway.) But if we decide that they belong to the input subsystem, I'd
> rather let Dmitry handle it.
>

I think you should pick it up. I consider presence of an input device
there as secondary to its main purpose of monitoring box state. It's
like DVB and video drivers - I don't insist on moving them into
drivers/input just because some of them have remote controls ;)

-- 
Dmitry
