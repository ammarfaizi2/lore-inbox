Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWEEOgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWEEOgg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWEEOgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:36:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:65460 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751562AbWEEOgg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:36:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KoBGdJmnDWBfZbAgoSEVZfKQQfoZJtkpgtwdAD+iUG2ldRI8vBgqL2za5om0PVAo70nw2PabgMD4O0IIh/ZkNB4IkCPCPZSgWiSjYApvvm8epEjL8i8s/wX2f8OxX7poJgy3s5cg0z+VYt4tXVedXd6OgUr1lfFmNEl7M5NnClk=
Message-ID: <6e0cfd1d0605050736g624c2a6fm68ab8b659fa6e253@mail.gmail.com>
Date: Fri, 5 May 2006 16:36:30 +0200
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Dan Merillat" <harik.attar@gmail.com>
Subject: Re: Kbuild + Cross compiling
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/06, Dan Merillat <harik.attar@gmail.com> wrote:
> I must be an idiot, but why does Kbuild rebuild every file when cross-compiling?
> I'm not editing .config or touching any headers, I'm making tweaks to
> a single .c driver,
> and it is taking forever due to continual full-rebuilds.

I had that problem a while ago. Turned out that the version of make I used on
my debian had a bug.

--
blue skies,
  Martin
