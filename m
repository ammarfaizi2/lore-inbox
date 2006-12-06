Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935390AbWLFPbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935390AbWLFPbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935436AbWLFPbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:31:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:11819 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935390AbWLFPbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:31:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TOY0h+vixpNLCfMioKPj13LYWPX2iVanEPeSUEMMlh+oDO/iQ2LMzLkdUgjQwRRPA2fR+aGGIJak/gz/XDTQcHjO4dtwe8djR/YefLkWFosgwPoVuo1npgYU3xt5GioSBzvD+Vk0jYITVClRefvoSpJOTuN0/1Y5DA3Xhv+QB5I=
Message-ID: <d120d5000612060731s3e1b4b6fnb8e93b970e91a852@mail.gmail.com>
Date: Wed, 6 Dec 2006 10:31:44 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jkosina@suse.cz>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
Cc: "Marcel Holtmann" <marcel@holtmann.org>, "Li Yu" <raise.sail@gmail.com>,
       "Greg Kroah Hartman" <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       "Vincent Legoll" <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
In-Reply-To: <Pine.LNX.4.64.0612061615080.29624@jikos.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612061803324532133@gmail.com>
	 <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
	 <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
	 <1165415924.2756.63.camel@localhost>
	 <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
	 <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com>
	 <Pine.LNX.4.64.0612061615080.29624@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 6 Dec 2006, Dmitry Torokhov wrote:
> > Is there any reason why we can't mecanically move everything into
> > drivers/hid right now? Then Greg could simply forward all patches he
> > gets for HID your way and you won't have hard time merging your work
> > with others...
>
> That definitely would be a possible solution.
>
> In fact, the patches for the split I sent to you and a few other people
> two weeks ago or so, do exactly this - in some sense "mechanical" split of
> the generic parts laying currently in USB hid, from the USB-specific ones,
> and moving them around (sure, some changes are done, like introducing data
> structures specific to usbhid, etc., but no rocket science yet).
>

If Greg is OK with that I would start with truly mechanical merge (no
now data structures, just move the files around) and merge this ASAP,
before we hit -rc1 or -rc2 at the latest. Then you can start puling up
your changesin the separate git tree.

> This would be nice to merge, if noone has any major objections, and do
> other development on top of that.
> I am currently trying to set up an account and git tree for this at
> kernel.org ... request sent, waiting for reply :)
>

Take up Marcel on his suggestion ;) I  could set up a tree too but I
am afraid I won't have enought time at the moment.

-- 
Dmitry
