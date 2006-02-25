Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWBYSwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWBYSwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWBYSwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:52:09 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:25824 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161054AbWBYSwH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:52:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oTbbfD747yXY3hPHHAy4dtkAQ8m7Q2/d2IzvRHskQD6R7EP+DEtEUQlBdK1JNLtGpPoqPSZTrmexHGBOo1s7vg9xIpW5hf8JByztvR+5SSFT7gJEhe2HzNjfmTmYqhmEMZgDp6MeyU5/hvxClmA7qCF61dFzWuNhdtgzUNrxX7g=
Message-ID: <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com>
Date: Sat, 25 Feb 2006 19:52:06 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Rik van Riel" <riel@redhat.com>
Subject: Re: creating live virtual files by concatenation
Cc: "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1271316508.20060225153749@dns.toxicfilms.tv>
	 <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com>
	 <612760535.20060225181521@dns.toxicfilms.tv>
	 <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Rik van Riel <riel@redhat.com> wrote:
> On Sat, 25 Feb 2006, Maciej Soltysiak wrote:
>
> > Code files, DNS zones, configuration files, HTML code. We are still
> > dealing with lots of text files today.
>
> You say it like it's a bad thing, but in truth I suspect
> people often deal with text files because they're EASY
> to manipulate through scripts, etc.
>

I agree 100%, plain text serial files are *easy*.

Given the swiss-army knife of tools we have at our disposal (cat, cut,
head, tail, sed, awk, split, sort, grep  and many more), plain text
files are very easy to manipulate - not to mention write apps to
manipulate. And that is a very good thing IMHO.

I can imagine quite a mess if I open a file that is really a view of
several files and then start manipulating text in it across "actual
file" boundaries  that could blow up easily.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
