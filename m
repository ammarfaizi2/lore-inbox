Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbVJ0WBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbVJ0WBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVJ0WBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:01:51 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:21817 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932657AbVJ0WBv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:01:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qnoFFOAxwkof3ujwRk+eQ96EZFpKDeh8ROqfpziptZPCcXlr/3LOVGSpYr3nMsKy913gUbMIVltkmRYJ+51K9BOo3k72ETpWQ1UXBvFHWEAygbpAx/V+45a4zC68MGq03LRGvYwfKfpJYVxCW2MlUKv9Q0cwFyMKt60v/dPnQ6Q=
Message-ID: <39e6f6c70510271501r2a2b816flba99994cf161af99@mail.gmail.com>
Date: Thu, 27 Oct 2005 20:01:50 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx>
Subject: Re: Patch that allows >=2.6.12 kernel to build on nls free systems
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Daniel Drake <dsd@gentoo.org>
In-Reply-To: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx> wrote:
> Hi all,
>
> I made a patch that detects if libintl.h (needed for nls) is present on
> the host system and if it's not, it nls support is disabled by
> providing dummies for the used nls functions.
>
> This way if there is nls support on the host system the *config targets
> will build according to Arnaldo Carvalho de Melo's i18n modifications,
> else it just uses the original English messages.

Haven't tested this myself, but looks like the way to go.

Thanks,

- Arnaldo
