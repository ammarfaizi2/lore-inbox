Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWALP7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWALP7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWALP7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:59:39 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:29452 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751418AbWALP7j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:59:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dcSKHytD0Kb3x46vhr3wqmv9yvmJ+MfUNGZSvWhstE95CzHwmr6IQJ7G3YisKKg3MN6Xf73iFaZsGx7gWAxEMBDsLeC7OeXzi1j4ZUcz64XSQj8GeMBVkclsiX10ur4BNSlX8+i1QCiV8K8661goYXy1fc2BunoZ0pQ3lIQUtio=
Message-ID: <d120d5000601120759n222c1e5av7caf60c02aa52331@mail.gmail.com>
Date: Thu, 12 Jan 2006 10:59:38 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: linux-2.6.15-git7: PS/2 keyboard dies on ppp traffic
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <43C66E82.4030106@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C66E82.4030106@ums.usu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/06, Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
> Hello,
>
> the main linux tree started suffering the same bug as described for -mm
> earlier in http://lkml.org/lkml/2005/11/7/147:
>
> if I put load on my system, connect to the Internet using my cellphone
> (/dev/ttyS0) and do something, it stops reacting to PS/2 keyboard
> events, but still understands PS/2 mouse. The PPP load monitor shows
> huge transfer rate (several megabytes per second) consisting of the
> infinitely replicated several last packets. events/0 consumes all the
> CPU. tty buffering revamping patch is the obvious candidate, but I
> haven't tried to revert it yet.
>

Do you have access to an USB keyboard?

--
Dmitry
