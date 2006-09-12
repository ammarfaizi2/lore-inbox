Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWILRMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWILRMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWILRMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:12:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:21546 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030268AbWILRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:12:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TXUD7fwQcwJfPDhvU8DaXHXLBddcOneXT0XtXMRMc4P/cwqegADZbW8C9dn795DINTE2TVOQrtQdKj3iOQJlVCv2w4gLUBd9qLjO4V0NaQnlbn/2enka1RSuF/Xy8bv7g4carQpCg3SiXmxTOZ/Q/v6jhNrSl21fxhPEnMODfXE=
Message-ID: <d120d5000609121012o684a098bx6bc2d497a17b1421@mail.gmail.com>
Date: Tue, 12 Sep 2006 13:12:29 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Piotr Gluszenia Slawinski" <curious@zjeby.dyndns.org>
Subject: Re: thinkpad 360Cs keyboard problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0609121611380.2685@Jerry.zjeby.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
	 <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org>
	 <20060910194955.GA1841@elf.ucw.cz>
	 <200609102054.34350.dtor@insightbb.com>
	 <Pine.LNX.4.63.0609120209590.2685@Jerry.zjeby.dyndns.org>
	 <d120d5000609120705r26a25b44q7533c528bccb25bf@mail.gmail.com>
	 <Pine.LNX.4.63.0609121611380.2685@Jerry.zjeby.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org> wrote:
> On Tue, 12 Sep 2006, Dmitry Torokhov wrote:
>
> > On 9/11/06, Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org> wrote:
>
> >>  kernel boots up fine, but keyboard is totally messed up,
> >>  and locks up after some tries of use.
> >
> > Could you try describing the exact issues with the keyboard? Missing
> > keypresses, wrong keys reported, etc?
>
> with prink enabled it prints series of 'unknown scancode'
> and keys are randomly messed up, and it changes, so like pressing b
> results with n, then space, then nothing at all.
> after some tries keyboard locks up completely.
>

Are you loading a custom keymap by any chance? Could I please see
dmesg with "i8042.debug log_buf_len=131072"?

-- 
Dmitry
