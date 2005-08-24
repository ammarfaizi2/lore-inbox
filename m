Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVHXKp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVHXKp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVHXKp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:45:28 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:28829 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbVHXKp1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:45:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZAE1o+KJRaWiVkLh949OjCxGEpySGs9bH93h3S9zOjNmQdiuVWqhkpXavBPOwsT6nV7F+jkMBgYO5X/M39WHB17MwGhTTsE97y/OqdStA4LKp6VUEHsJlXzZiO1EJxwwRNxRJJtQO+FLr/Va2o40w7JmUq1OUqbv9SRA/5h2zcM=
Message-ID: <9a8748490508240345387e3ef6@mail.gmail.com>
Date: Wed, 24 Aug 2005 12:45:24 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Subject: Re: delay
Cc: raja <vnagaraju@effigent.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <430C47F6.8050805@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <430C1772.4030308@effigent.net> <430C47F6.8050805@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/05, Vladimir V. Saveliev <vs@namesys.com> wrote:
> Hello
> 
> raja wrote:
> > Hi,
> >    Would you please tell me how to write a function that generates a
> > delay of Less than a sec.(ie for 1 milli se or one microsec etc).
> >
> 
> Maybe you could use: linux/kernel/timer.c:schedule_timeout()
> 

udelay() / ndelay() ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
