Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946194AbWJSQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946194AbWJSQgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946210AbWJSQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:36:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:36885 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946209AbWJSQf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:35:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bWmChnUSW3k8IW4zJoLCaPQ/Y2BbpWoGZvZYM2WXj+chwaD+vZfFAMa+WMdyYX2Y3lO0Vo6cXMSKQf8rro4jW4x2Tz+5HB0QeUZ4wCFRtT5MoW88SSy+fGzXnw2+BAxXuhvW/HVc+Nvkh66uKh3wKRzTO1iE6iVRLeq72lZovVo=
Message-ID: <c43b2e150610190935tefd11eev510c7dee36c15a51@mail.gmail.com>
Date: Thu, 19 Oct 2006 18:35:56 +0200
From: wixor <wixorpeek@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: VCD not readable under 2.6.18
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161124732.5014.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
	 <1161040345.24237.135.camel@localhost.localdomain>
	 <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com>
	 <1161124732.5014.20.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Now where it all gets weirder is that some forms of VCD (especially the
> ones for philips short lived interactive stuff) have an ISO file system
> on them but where sector numbers in the file system for video blocks
> point to blocks that are not 2K data blocks but mpeg blocks that the
> file system layer can't handle, so a VCD disk can appear mountable and
> the like.
OK, but this is still mountable only from windows....... Is this ISO
filesystem hidden somewhere, or what? And that still does not explain
errors from xine, and the 8 megs that i actually can read using dd.
All after all - even if this disc would contain totally unsupported
tracks, with absolutly weird data, kernel should recognize it and
report something like:
cdrom: there are no tracks on hda i can recognize
(or something like that). If the errors do happen, it means kernel
thinks he can read the data, and he actually can't, yes? Is here
anything I can do to improve support of this disc under linux, or is
this just another hell-knows-what thing, the kernel implementation is
ok, and this is only some m$-dontated extension that prevents us from
accessing this disc? Even if it is, shouldn't it be implemented if it
is possible?

Thanks
--
wixor
