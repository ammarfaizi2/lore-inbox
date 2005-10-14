Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVJNL67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVJNL67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 07:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVJNL67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 07:58:59 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:7756 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750721AbVJNL66 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 07:58:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T68Jvm58g/bfSCx6lBQqoJ52A758/0K30T232ghC5MCM0ObjwZgrl5L0O8DhGTDx8qa5JMmsEPj95Q1ufl3atckflhXV1rOoh1jxsuTAMUaKFmCzDz1auHdsM8PCRV90YlUYJ1KOB1PKo7WLadeCovlMvFLMD408yNreoPdtZas=
Message-ID: <9a8748490510140458y7b490077tb08a3155e5e2ae38@mail.gmail.com>
Date: Fri, 14 Oct 2005 13:58:57 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>,
       "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
       Jakub Jelinek <jj@ultra.linux.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Roland Dreier <rolandd@cisco.com>,
       Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pierre Ossman <drzeus-wbsd@drzeus.cx>,
       Carsten Gross <carsten@sol.wh-hms.uni-ulm.de>,
       Greg Kroah-Hartman <greg@kroah.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Vinh Truong <vinh.truong@eng.sun.com>,
       Mark Douglas Corner <mcorner@umich.edu>,
       Michael Downey <downey@zymeta.com>, Antonino Daplas <adaplas@pol.net>,
       Ben Gardner <bgardner@wabtec.com>
In-Reply-To: <vJmVlab2.1129281869.1524300.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510132128.45171.jesper.juhl@gmail.com>
	 <vJmVlab2.1129281869.1524300.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/05, Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Jesper,
>
> On 2005-10-13, Jesper Juhl wrote:
> > This is the remaining misc drivers/ part of the big kfree cleanup patch.
> >
> > Remove pointless checks for NULL prior to calling kfree() in misc files
> > in drivers/.
>
> The hwmon and i2c parts are fine by me.
>
> Acked-by: Jean Delvare <khali@linux-fr.org>
>
Great, thanks.

> BTW, what's the merge plan? Andrew enqueues the whole stuff, or do you
> expect each individual maitainer to extract his/her part?
>

I was hoping for maintainers to ack the patches and then have Andrew
queue the whole thing.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
