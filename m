Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWCVSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWCVSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCVSA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:00:27 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:37070 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932197AbWCVSA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:00:26 -0500
Date: Wed, 22 Mar 2006 19:01:46 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Martin Schwidefsky" <schwidefsky@googlemail.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/6] s390: minor claw driver fix
Message-ID: <20060322190146.115a7a01@localhost.localdomain>
In-Reply-To: <6e0cfd1d0603220742m80e553x461362297bf38e53@mail.gmail.com>
References: <20060322162821.6ebd9af6@localhost.localdomain>
	<6e0cfd1d0603220742m80e553x461362297bf38e53@mail.gmail.com>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 16:42:14 +0100
"Martin Schwidefsky" <schwidefsky@googlemail.com> wrote:

> On 3/22/06, Frank Pavlic <fpavlic@de.ibm.com> wrote:
> > [patch 1/6] s390: minor claw driver fix
> >
> > From: Frank Pavlic <fpavlic@de.ibm.com>
> >
> >         use CONFIG_ARCH_S390X instead of CONFIG_64BIT in function dumpit .
> 
> Nack. CONFIG_ARCH_S390X doesn't exists anymore. It has been replaced
> by CONFIG_64BIT in 2.6.16.
> 
> --
> blue skies,
>   Martin

oh boy , you are absolutely right , did take the wrong kernel level for making this patch .
it was just before you did the upgrade to 2.6.16 :-(..

Jeff please don't apply this one ...the rest [2/6] - [6/6] is ok ...

Frank
