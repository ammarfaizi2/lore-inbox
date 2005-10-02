Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVJBStd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVJBStd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 14:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJBStd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 14:49:33 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:53162 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751139AbVJBStc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 14:49:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=umJ5o1tqJv2ywsXuPt2Qza3YpupawZpnKkKbNTiiZNP08REVvlkQYpNkqpml97OsuO+hoEHuoZaNAnsfw8EjinAjIfsOPZAWKwcYI9lv7vMsAB2OHxsUjtOOMUeMxPgtId4BeKJwGNavvNrp/4EkooNJCF5bAQ5HOV/lXWFdT54=
Message-ID: <35fb2e590510021149l63cb27b9sb231925cdda3bfce@mail.gmail.com>
Date: Sun, 2 Oct 2005 19:49:31 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: lokum spand <lokumsspand@hotmail.com>
Subject: Re: A possible idea for Linux: Save running programs to disk
Cc: mike@concannon.net, arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <433F0BF1.2020900@concannon.net>
	 <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, lokum spand <lokumsspand@hotmail.com> wrote:

> In fact moving processes from one machine to another would be a brilliant
> feature at my work, since we run fairly large and time-consuming simulations
> on electronic circuits. If the kernel could natively support bouncing jobs
> back and forth, that would really be something. Since we simulate with
> proprietary software, I suppose we can't rely on the simulator being
> rewritten to support such special libraries.

But it does that. Projects like OpenMOSIX can abuse the already
existing migration code in the scheduler, Xen supports moving whole
virtual machines on the fly. There are others too.

> Does any other Unix variant have process bouncing already?

Lots.

Cheers!

Jon.
