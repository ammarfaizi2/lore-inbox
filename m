Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWHOL6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWHOL6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWHOL6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:58:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:44874 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030276AbWHOL6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:58:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e7jM+rARObjgsSewLCWcttZLJvsDYYRuguaf/3KQxFFDAvtupwXv1TUFFn37zjs57NJ7OQPlLMcKBWUxt/z/i+PNTQdAuD+tKwysc8ZeSLxMtOCrDIYCt+E2IILPEWfngWRjv08z3rJpI68qWpW8PJGfoMo5Mv3yo9KYiIZF2vU=
Message-ID: <9a8748490608150458t53da165cvca0f6bf71c25ed63@mail.gmail.com>
Date: Tue, 15 Aug 2006 13:58:02 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: locks_insert_block: removing duplicated lock (pid=2711 0-9223372036854775807 type=1)
In-Reply-To: <9a8748490608100502wd9a097cwab80c662300020e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608100502wd9a097cwab80c662300020e8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> I've got a server running 2.6.11.11 that just reported the following in dmesg :
>
> locks_insert_block: removing duplicated lock (pid=2711
> 0-9223372036854775807 type=1)
>
Still getting lots of these :

Aug 15 13:53:01 server kernel: locks_insert_block: removing duplicated
lock (pid=3 0-9223372036854775807 type=1)
Aug 12 22:46:31 server kernel: locks_insert_block: removing duplicated
lock (pid=1036 0-9223372036854775807 type=1)
Aug 12 00:21:28 server kernel: locks_insert_block: removing duplicated
lock (pid=1020 0-9223372036854775807 type=1)

What's the exact meaning of this?
> Should I worry?
> Any info I can provide that would be useful?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
