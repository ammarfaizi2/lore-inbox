Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWEDSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWEDSef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWEDSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 14:34:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:45149 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750762AbWEDSee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 14:34:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o2U/B2wQZ3Av8uacm8Tt2aWsxrmt8SQkQyiqK4zdaVBePyy/e6Y46a36YFK8GCSQWoR5OigGQ0AP1anQxft90u+4+iJxr3jfAMCWfAvffNZMLok3cCCiOfG9NpojkW4aVJU3BHcueQYT4TLLSDYXaQyUBteGx/fR23mcjMii13Y=
Message-ID: <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com>
Date: Thu, 4 May 2006 14:34:34 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: Remove silly messages from input layer.
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <445A18D8.1030502@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz>
	 <445A18D8.1030502@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Martin J. Bligh <mbligh@mbligh.org> wrote:
> Pavel Machek wrote:
> > On Wed 03-05-06 22:44:04, Dave Jones wrote:
> >
> >>There are two messages in the input layer that seem to be
> >>triggerable very easily, and they confuse end-users to no end.
> >>"too many keys pressed? Should I press less keys?"
> >
> >
> > It actually means 'type more slowly' or 'use standard keymap' or 'get
> > a better keyboard' :-) or 'no, you are not imagining it, I've seen
> > your keypress and dropped it'.
>
> Perhaps it should say that then ;-)
>

Do you have a beter wording in mind? "Keyboard reports too many keys
were pessed at once, some keystrokes might be dropped"?

Also I don't understand what people have against this message, it's at
KERN_DEBUG level after all.

--
Dmitry
