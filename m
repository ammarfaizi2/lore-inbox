Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVAJXim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVAJXim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVAJXff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:35:35 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:29556 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262793AbVAJXSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:18:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=L/ZIZkW7/8USbK9u2M2Om2P2xuwG+2nJ+qq1i4t/M7JZb9X7BdQrkeMoni44MfeZ6rZzDdvZaf+fGy5dKCd5kPFpyrFYWTNq29kul99B2zZGFYZhmJmeu1qiS0HD1GgFhsy/GVhMPgTFFMXpZYBBLHC+UGWBPpjC+addxjPiUPo=
Message-ID: <4d6522b90501101518293c025e@mail.gmail.com>
Date: Tue, 11 Jan 2005 01:18:24 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: User space out of memory approach
Cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <4d6522b90501101517420fced6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <4d6522b90501101517420fced6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually 'than' is much better then :-)


On Tue, 11 Jan 2005 01:17:01 +0200, Edjard Souza Mota <edjard@gmail.com> wrote:
> Hi,
> 
> >
> > Sorry, I misunderstood. Should have read the code before shouting.
> 
> Better shouting then shooting :)!
> 
> br
> 
> Edjard
> 
> 
> >
> > The feature is interesting - several similar patches have been around with similar
> > functionality (people who need usually write their own, I've seen a few), but none
> > has ever been merged, even though it is an important requirement for many users.
> >
> > This is simple, an ordered list of candidate PIDs. IMO something similar to this
> > should be merged. Andrew ?
> >
> > Few comments about the code:
> >
> >  retry:
> > -       p = select_bad_process();
> > +       printk(KERN_DEBUG "A good walker leaves no tracks.\n");
> > +       p = select_process();
> >
> > You want to fallback to select_bad_process() if no candidate has been selected at
> > select_process().
> >
> > You also want to move "oom" to /proc/sys/vm/.
> >
> >
> 
> --
> "In a world without fences ... who needs Gates?"
> 


-- 
"In a world without fences ... who needs Gates?"
