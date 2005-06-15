Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFOSBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFOSBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFOSBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:01:52 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:64901 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261254AbVFOSAG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:00:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GQL6LNDytxXgM/pXL902hQh6oOXcSM0Xt8nxImnmXuPtoSmi32Dc3cGF1EYuSyB52wP3ZnAw/KEWnVyGe6fukJGzzM59dIapYg8KMnmqWRYtz+Ai+Y6hQ1ZhjK0tEqKmqaufyntgAMNNhP1HC6rXOTgVERumNYd28YkTk9xt/Mg=
Message-ID: <9a874849050615110043f62c1@mail.gmail.com>
Date: Wed, 15 Jun 2005 20:00:04 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Avery Fay <avery@ravencode.com>
Subject: Re: via-rhine broken in 2.6.12-rc6 and 2.6.11 stable
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118856017.2987.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1118854779.3107.7.camel@localhost.localdomain>
	 <1118856017.2987.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/05, Avery Fay <avery@ravencode.com> wrote:
> Nevermind about the stable kernel part. For some reason, my symbolic
> links were not getting updated right. But it definitely doesn't work on
> 2.6.12-rc6 

I'm using the via-rhine module here, and it works just fine in both
2.6.12-rc6, 2.6.12-rc6-git6 and 2.6.12-rc6-mm1


>and it's definitely related to vmware. Is this something that
> vmware needs to fix?

If you are loading closed source vmware modules into your kernel and
then things stop working but they are fine without the modules loaded,
then yes, that's a problem between you and vmware - get in touch with
vmwares support.
If you can reproduce the problem *without* the vmware modules, then
it's an issue for LKML.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
