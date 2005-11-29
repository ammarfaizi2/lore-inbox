Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVK2BTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVK2BTS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVK2BTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:19:18 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:39344 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932317AbVK2BTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:19:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=g0gwSAdS+gJQWNHZjceeU3XGQGDz/23qKYYZ9LjWIJaM2a/AQdhFvTVPMkSJViQ18BXyODYAD7jQTpbi1VBRwo295Fs3EIfBrBnqoQGWUrl0qhNWFIKRCBsQfu6M3gG+zUeTRxgTzb3r9DXkag4OtCyGMJYWjCyN4CCpuQnvCX8=
Date: Tue, 29 Nov 2005 04:33:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] un petite hack: /proc/*/ctl
Message-ID: <20051129013354.GA17749@mipter.zuzino.mipt.ru>
References: <20051129002801.GA9785@mipter.zuzino.mipt.ru> <D6440692-33C3-45F0-9112-C22332ED7072@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6440692-33C3-45F0-9112-C22332ED7072@bootc.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 12:23:19AM +0000, Chris Boot wrote:
> On 29 Nov 2005, at 0:28, Alexey Dobriyan wrote:
> >echo kill >/proc/$PID/ctl
> >	send SIGKILL to process
> >
> >echo term >/proc/$PID/ctl
> >	send SIGTERM to process
>
> Pardon me for my ignorance, but what's wrong with the following?
>
> kill -KILL $PID
>     and
> kill -TERM $PID

kill(1) existence. Not that I'm seriously proposing patch for inclusion.

