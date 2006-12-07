Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163425AbWLGVh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163425AbWLGVh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163423AbWLGVh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:37:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:40289 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163428AbWLGVhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:37:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hbvInbS1PxW0cUyYrz6q+F5f/vvTZV9oFjyvaNlVfGt905YzHezMMDXAHgaskUKhQr6DnRTapbdv/T5H6Cpf+Jaji3evLb1aCygIk5hsOFdhIGXYOGF0cYVISjPadP5Sa2yC2Xgv1TXz+/K6jQ9GLt+Wrnedfear8QWVXGc9If8=
Message-ID: <9a8748490612071337p612f7a2t5fd31968a9ff5da9@mail.gmail.com>
Date: Thu, 7 Dec 2006 22:37:54 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: additional oom-killer tuneable worth submitting?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457886B4.2030507@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45785DDD.3000503@nortel.com>
	 <9a8748490612071050q60b378c4ldf039140ffd721be@mail.gmail.com>
	 <457886B4.2030507@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/06, Chris Friesen <cfriesen@nortel.com> wrote:
> Jesper Juhl wrote:
>
> > What happens in the case where the OOM killer really, really needs to
> > kill one or more processes since there is not a single drop of memory
> > available, but all processes are below their configured thresholds?
>
> Then the system wasn't properly engineered.  <grin>
>
I had a feeling you'd say that.

> In this case you reboot.
>
I realize that if this case happens the system is misconfigured as far
as oomthresh goes, but if this is a knob that we put in the mainline
kernel then I believe there should be some sort of emergency handling
code that takes this situation into account.  Perhaps throw some very
nasty looking log messages and then fall back to the classic OOM
killer behaviour..?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
