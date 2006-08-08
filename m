Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWHHRmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWHHRmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWHHRmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:42:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:47058 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965015AbWHHRmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:42:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oexFzqebtfaQse9wvJ6aGRAMu3MweILkvaf5WXwc98/ahacvoa2uvB6Is3UrfSsOJ28qWJDaQbsESekj3zmogAB17JJXp+kIT06cMiMkCwQShd7JMVQcbgFkXdIFgbh/oq6lbG051Gvxn7HKe+TLBdrzrL4l8PAtzsEmr6zHgx4=
Message-ID: <d120d5000608081042i46eca97fvf1c3d67db65731b9@mail.gmail.com>
Date: Tue, 8 Aug 2006 13:42:36 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc3-mm2
Cc: "Fabio Comolli" <fabio.comolli@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608081641.48621.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <b637ec0b0608071147kb8a191bka9d6afe5b5287d08@mail.gmail.com>
	 <d120d5000608071200k3eb2bfd6v166c6bc92f5dcadf@mail.gmail.com>
	 <200608081641.48621.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 07 August 2006 21:00, Dmitry Torokhov wrote:
> > On 8/7/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> ]--snip--[
> > >
> > > Still interested in dmesg with i8042.debug=1 ?
> > >
> >
> > Yes, _with_ the i8042 polling patch applied.
>
> I've got one for you (attached).
>

Thnk you, I think I see what the problem is. Rafael, could you please
try booting with i8042.nomux and tell me if mouse starts working.

Fabio, do you have a multiplexing controller as well?

-- 
Dmitry
