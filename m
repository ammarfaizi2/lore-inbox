Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288982AbSAITte>; Wed, 9 Jan 2002 14:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288981AbSAITtZ>; Wed, 9 Jan 2002 14:49:25 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:63269 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S288982AbSAITtR> convert rfc822-to-8bit; Wed, 9 Jan 2002 14:49:17 -0500
Date: Wed, 9 Jan 2002 20:47:15 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "J.A. Magallon" <jamagallon@able.es>
cc: jtv <jtv@xs4all.nl>, Tim Hollebeek <tim@hollebeek.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, <paulus@samba.org>,
        <gcc@gcc.gnu.org>, <linux-kernel@vger.kernel.org>,
        <trini@kernel.crashing.org>, <velco@fadata.bg>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020108012734.E23665@werewolf.able.es>
Message-ID: <20020109204043.T1027-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, J.A. Magallon wrote:

>
> On 20020107 jtv wrote:
> >
> >Let's say we have this simplified version of the problem:
> >
> >	int a = 3;
> >	{
> >		volatile int b = 10;
>
>     >>>>>>>>> here b changes

Hmmm...
Then your hardware is probably broken or may-be you are dreaming. :-)

There is nothing in this code that requires the compiler to allocate
memory for 'b'. You just invent the volatile constant concept. :)

> >		a += b;
> >	}
> >
> >Is there really language in the Standard preventing the compiler from
> >constant-folding this code to "int a = 13;"?

Gérard.

