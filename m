Return-Path: <linux-kernel-owner+w=401wt.eu-S932161AbXACWfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbXACWfO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbXACWfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:35:13 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:53700 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbXACWfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:35:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zm5QLVA13L6s4aQ/UdgSz/PHOK7kdiD3PTRdNZ7LAfYQbGOnn5+BtBmzHJGAQPnR9GAH/ltWKpKUMTEd+76V8GDPVJ/tvGi5BXs1vFM45GIn/H5sJjU9oYfuayDUvJO+JzPmEw8vOa4woX0L1zuIfbcjTrTReKvxYZkAfD2K164=
Message-ID: <6bb9c1030701031435w7955571al4ccfedfc2a9025b8@mail.gmail.com>
Date: Wed, 3 Jan 2007 23:35:10 +0100
From: "Pelle Svensson" <pelle2004@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: Symbol links to only needed and targeted source files
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070103215850.GA32137@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com>
	 <20070103162409.GA30071@uranus.ravnborg.org>
	 <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
	 <20070103215850.GA32137@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/07, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jan 03, 2007 at 10:14:43PM +0100, Pelle Svensson wrote:
> > Hi Sam,
> >
> > You misunderstand me I think, I already using a separate output directory.
> > What I like to do is a separate 'source tree' with only valid files
> > for my configuration. In that way, when I use grep for instance,
> > I would only hit valid files and not 50 other files which are
> > not in the current build configuration.
>
> I see.
> There is nothing in kbuild that will help you to achieve this.
> If you build the kernel and parse all .*.cmd files then
> you can build a complete list of files used and create your
> symlinked tree.
> But then you need a fully build kernel to do so.
>
> I see no easy way to get the info without building the kernel
> and if we do this only as a preprocessing step then we will
> most likely not integrate it in kbuild since the user base will
> be small. But if you hack up something lets take a look at it.
>
>         Sam
>

Hi Sam,

Ok, at least I know I'm not doing double work.

/Thanks
