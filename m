Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTDULHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTDULHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:07:38 -0400
Received: from mail.ithnet.com ([217.64.64.8]:61201 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263303AbTDULHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:07:37 -0400
Date: Mon, 21 Apr 2003 13:19:34 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030421131934.1f6e29b0.skraw@ithnet.com>
In-Reply-To: <03Apr21.020150edt.41463@gpu.utcc.utoronto.ca>
References: <mail.linux.kernel/20030420185512.763df745.skraw@ithnet.com>
	<03Apr21.020150edt.41463@gpu.utcc.utoronto.ca>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003 02:01:46 -0400
someone wrote:

> You write:
> | Can you tell me what is so particularly bad about the idea to cope a
> | little bit with braindead (or just-dying) hardware?
> 
> [...]
>  It probably could be done. I do not think it would be small or easy.
> Especially if filesystem developers feel that modern drives only start
> experiencing user-visible write errors about when they are going to
> explode in general, they may rationally feel that the work is not worth
> it.

I can very well accept that argument. What I am trying to do is only make
_someone_ writing a fs listen to the problem, and maybe - only maybe - in _his_
fs it is not as complicated and so he simply hacks it in. I am only arguing for
having a choice. Not more. If e.g. reiserfs had the feature I could simply
shoot all extX stuff and use my preferred fs all the time. That's just about
it. No religion involved. I am not arguing this type of feature as a
_must-have_. I only think regarding the neat stuff that is already inside
reiser (just to name my currently preferred fs) it would be very kind to have
write-error-recovery additionally.

Regards,
Stephan

