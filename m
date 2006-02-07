Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWBGWpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWBGWpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBGWpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:45:01 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:3223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932468AbWBGWnP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ByVZ+nmJ1h54STtAaQ+LzTTuZYTRx6/Hs9eIfcbk/FSM3fzLZUxwtKhsJmUh9smQWQg0Qo+brvpEdyfBKdmXBdbypHGM3hz6rjqHXu/O1Wcz+7nMcymdVNA4QsFKYctaxoUgrRbp4COh2hxhyse4Q740XAl8wDpHil5wlCqkrCs=
Message-ID: <9a8748490602071443u78709ac5h4303ffe42b847f64@mail.gmail.com>
Date: Tue, 7 Feb 2006 23:43:14 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Two Oopses at boot with 2.6.16-rc2-git1 - Unable to handle kernel paging request at virtual address ...
In-Reply-To: <200602062000.12388.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602062000.12388.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> I just got two Oopses at boot with 2.6.16-rc2-git1 :
>
> Unable to handle kernel paging request at virtual address f49667f8
>  printing eip:
> c0233ccf
> *pde = 00490067
> Oops: 0000 [#1]
>
>  <1>Unable to handle kernel paging request at virtual address f49668c0
>  printing eip:
> c0236ac7
> *pde = 00490067
> Oops: 0000 [#2]
>
> The oopses are not fatal. The system continues to operate (seemingly) just
> fine, in fact I'm still using the machine to compose this mail (I'll reboot
> soon though to see if it ocours again on a second boot).
>

It seems these two ooses were a one-time thing. I've booted the
machine a few times since (with the same kernel ofcourse) and I've not
seen the oppses again.
Would still like to know what could have caused them though.


> Complete dmesg output including the oopses, backtraces etc can be found
> below along with some information about my system - let me know if more
> info is needed.
>
[snip system details from previous mail]


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
