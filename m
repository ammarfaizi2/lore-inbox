Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbULaPm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbULaPm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbULaPm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:42:56 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:50717 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262110AbULaPmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 10:42:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HdP5UCDvjmeEn/ZkNPwsrGezyRBa2NnMBdrFUFnWLkE51CYE7tz1FZVYLJgUzcSKq+fYO9KtoEVtWlSDp7Tje8eCYcv/9bTXcR6qYN4LmxziAlg6NkFpV8kd4GsPSKPlAp20Py3Fkh0kYR8ioBz8s1ak+AlKgHE5oe8LimRfQ6E=
Message-ID: <53046857041231074248b111d5@mail.gmail.com>
Date: Fri, 31 Dec 2004 08:42:54 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
In-Reply-To: <1104499860.3594.5.camel@littlegreen>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <1104401393.5128.24.camel@gamecube.scs.ch>
	 <1104411980.3073.6.camel@littlegreen>
	 <200412311413.16313.sailer@scs.ch>
	 <1104499860.3594.5.camel@littlegreen>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> I don't think that the Wine problem resolution is due to the POPF 
> instruction handling. Basically Linus patch does a nice cleanup plus POPF 
> handling, so maybe the patch can be split.

If you or Andi or anyone else wants to split up the patch and have me
test it, I'd be willing.  I could try it myself if you want, though it
will be later, as I have to leave soon.  But I really do think that it
does have to do with POPF, since that alone seems to make wine happier
all-round.

Jesse
