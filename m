Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWJDDve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWJDDve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWJDDve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:51:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:50193 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751100AbWJDDvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:51:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xld3WITgLo9dDDbtVHgd7SVZJSfyRxVQq3eyJtxkzXNqzJkO/XJZ6AQmd0Aru/BMszcEyh9Zc7zcL3ARux0LR0Kdn9rJ2XPA6UWe50sCy+orE8XH7qIOQYyGdv8ZCbnRT2YlLnnoZ0ijrEWp4JCDu9QhjOC0N2CZzq5MB9gDgio=
Message-ID: <a36005b50610032051h64609d51kf1e5211d1bf07370@mail.gmail.com>
Date: Tue, 3 Oct 2006 20:51:31 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <efv8pc$31o$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45150CD7.4010708@aknet.ru> <45229C8E.6080503@redhat.com>
	 <4522A691.7070700@aknet.ru> <4522B7CD.4040206@redhat.com>
	 <efv8pc$31o$1@taverner.cs.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, David Wagner <daw@cs.berkeley.edu> wrote:
> Are you familiar with the mmap(PROT_EXEC, MAP_ANONYMOUS) loophole?

Another person who doesn't know about SELinux.  Read

http://people.redhat.com/drepper/selinux-mem.html
